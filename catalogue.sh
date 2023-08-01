
log=/tmp/roboshop.log

echo -e "\e[31m>>>>>>  Create  a  Catalogue Service File <<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp catalogue.service /etc/systemd/system/catalogue.service &>> ${log}

echo -e "\e[31m>>>>>>   Create a MongoDb Reo File <<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp mongo.repo /etc/yum.repos.d/mongo.repo  &>> ${log}

echo -e "\e[31m>>>>>>   Installing Nodejs Repo File  <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> ${log}

echo -e "\e[31m>>>>>>  Installing Nodejs <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
yum install nodejs -y  &>> ${log}

echo -e "\e[31m>>>>>>  Create Application User  <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
useradd roboshop &>> ${log}

echo -e "\e[31m>>>>>>  Cleaning Application  Content <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
rm -rf /app &>> ${log}

echo -e "\e[31m>>>>>>  Create Application Directory <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
mkdir /app &>> ${log}

echo -e "\e[31m>>>>>>   Downloading Application Content <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> ${log}



echo -e "\e[31m>>>>>>  Extracting Application Content <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
cd /app  &>> ${log}
unzip /tmp/catalogue.zip  &>> ${log}


echo -e "\e[31m>>>>>> Installing Application Dependencies <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
cd /app  &>> ${log}
npm install  &>> ${log}

echo -e "\e[31m>>>>>>  Reloading a Deamon   <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
systemctl daemon-reload   &>> ${log}

echo -e "\e[31m>>>>>>  Starting a Catalogue Service <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
systemctl enable catalogue  &>> ${log}
systemctl start catalogue  &>> ${log}

echo -e "\e[31m>>>>>>  Installing Mongodb Client Shell <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
yum install mongodb-org-shell -y  &>> ${log}

echo -e "\e[31m>>>>>>   Load  a Cataloguie Schema  <<<<<<<<<<<<<\e[0m"  | tee -a ${log}
mongo --host mongodb-dev.pdevopst74.online </app/schema/catalogue.js  &>> ${log}


