
echo -e "\e[31m>>>>>>  Create  a  Catalogue Service File <<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>   Create a MongoDb Reo File <<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo  &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>   Installing Nodejs Repo File  <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>  Installing Nodejs <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
yum install nodejs -y  &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>  Create Application User  <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>  Cleaning Application  Content <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
rm -rf /app &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>  Create Application Directory <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
mkdir /app &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>   Downloading Application Content <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/roboshop.log



echo -e "\e[31m>>>>>>  Extracting Application Content <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
cd /app  &>> /tmp/roboshop.log
unzip /tmp/catalogue.zip  &>> /tmp/roboshop.log


echo -e "\e[31m>>>>>> Installing Application Dependencies <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
cd /app  &>> /tmp/roboshop.log
npm install  &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>  Reloading a Deamon   <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
systemctl daemon-reload   &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>  Starting a Catalogue Service <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
systemctl enable catalogue  &>> /tmp/roboshop.log
systemctl start catalogue  &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>  Installing Mongodb Client Shell <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
yum install mongodb-org-shell -y  &>> /tmp/roboshop.log

echo -e "\e[31m>>>>>>   Load  a Cataloguie Schema  <<<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
mongo --host mongodb-dev.pdevopst74.online </app/schema/catalogue.js  &>> /tmp/roboshop.log


