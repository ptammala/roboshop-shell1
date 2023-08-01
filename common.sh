func_nodejs(){

log=/tmp/roboshop.log

echo -e "\e[31m>>>>>>  Create  a  ${component} Service File <<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp ${component}.service /etc/systemd/system/${component}.service &>> ${log}

echo -e "\e[31m>>>>>>   Create a MongoDb Reo File <<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp mongo.repo /etc/yum.repos.d/mongo.repo  &>> ${log}

echo -e "\e[31m>>>>>>   Installing Nodejs Repo File  <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> ${log}

echo -e "\e[31m>>>>>>  Installing Nodejs <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
yum install nodejs -y  &>> ${log}

func_apppreq

echo -e "\e[31m>>>>>> Installing Application Dependencies <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
cd /app  &>> ${log}
npm install  &>> ${log}

func_systemd

echo -e "\e[31m>>>>>>  Installing Mongodb Client Shell <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
yum install mongodb-org-shell -y  &>> ${log}

echo -e "\e[31m>>>>>>   Load  a Cataloguie Schema  <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
mongo --host mongodb-dev.pdevopst74.online </app/schema/${component}.js  &>> ${log}

}

func_systemd(){
  echo -e "\e[31m>>>>>>  Starting a Catalogue Service <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
  systemctl daemon-reload   &>> ${log}
  systemctl enable ${component}  &>> ${log}
  systemctl start ${component}  &>> ${log}
}


func_apppreq(){

  echo -e "\e[31m>>>>>>  Create Application User <<<<<<<<<<<<<\e[0m"  | tee -a ${log}

  useradd roboshop

  echo -e "\e[31m>>>>>>  Cleaning Application  Content <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
  rm -rf /app &>> ${log}

  echo -e "\e[31m>>>>>>  Create Application Directory <<<<<<<<<<<<<\e[0m"  | tee -a ${log}

  mkdir /app

  echo -e "\e[31m>>>>>>  Downloading  Application Content <<<<<<<<<<<<<\e[0m"  | tee -a ${log}

  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  cd /app

  echo -e "\e[31m>>>>>>  Extracting  Application Content  <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
  unzip /tmp/${component}.zip

}

func_java(){

log=/tmp/roboshop.log

echo -e "\e[31m>>>>>>  Installing Maven <<<<<<<<<<<<<\e[0m" | tee -a ${log}

yum install maven -y

echo -e "\e[31m>>>>>>  Create  a  ${component} Service File <<<<<<<<<<<<<\e[0m" | tee -a ${log}

cp shipping.service /etc/systemd/system/${component}.service

func_apppreq

echo -e "\e[31m>>>>>>  Building  a  ${component} Service <<<<<<<<<<<<<\e[0m" | tee -a ${log}

cd /app
mvn clean package
mv target/${component}-1.0.jar ${component}.jar

echo -e "\e[31m>>>>>>  Installing MYSQL <<<<<<<<<<<<<\e[0m" | tee -a ${log}
yum install mysql -y

echo -e "\e[31m>>>>>>  Load Schema   <<<<<<<<<<<<<\e[0m" | tee -a ${log}

mysql -h mysql-dev.pdevopst74.online -uroot -pRoboShop@1 < /app/schema/${component}.sql

func_systemd
}