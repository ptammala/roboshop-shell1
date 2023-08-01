
echo -e "\e[31m>>>>>>  Create  a  Catalogue Service File <<<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[31m>>>>>>   Create a MongoDb Reo File <<<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[31m>>>>>>   Installing Nodejs Repo File  <<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[31m>>>>>>  Installing Nodejs <<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[31m>>>>>>  Create Application User  <<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[31m>>>>>>  Create Application Directory <<<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[31m>>>>>>   Downloading Application Content <<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[31m>>>>>>  Cleaning Application  Content <<<<<<<<<<<<<\e[0m"
rm -rf /app

echo -e "\e[31m>>>>>>  Extracting Application Content <<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip


echo -e "\e[31m>>>>>> Installing Application Dependencies <<<<<<<<<<<<<\e[0m"
cd /app
npm install

echo -e "\e[31m>>>>>>  Reloading a Deamon   <<<<<<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[31m>>>>>>  Starting a Catalogue Service <<<<<<<<<<<<<\e[0m"
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[31m>>>>>>  Installing Mongodb Client Shell <<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[31m>>>>>>   Load  a Cataloguie Schema  <<<<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.pdevopst74.online </app/schema/catalogue.js


