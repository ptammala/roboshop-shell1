
echo ">>>>>>  Create  a  Catalogue Service File <<<<<<<<<<<<<"
cp catalogue.service /etc/systemd/system/catalogue.service

echo ">>>>>>   Create a MongoDb Reo File <<<<<<<<<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>>>   Installing Nodejs Repo File  <<<<<<<<<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>>>  Installing Nodejs <<<<<<<<<<<<<"
yum install nodejs -y

echo ">>>>>>  Create Application User  <<<<<<<<<<<<<"
useradd roboshop

echo ">>>>>>  Create Application Directory <<<<<<<<<<<<<"
mkdir /app

echo ">>>>>>   Downloding Application Content <<<<<<<<<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>>>  Extracting Application Content <<<<<<<<<<<<<"
cd /app
unzip /tmp/catalogue.zip


echo ">>>>>> Installing Application Dependencies <<<<<<<<<<<<<"
cd /app
npm install

echo ">>>>>>  Reloading a Deamon   <<<<<<<<<<<<<"
systemctl daemon-reload

echo ">>>>>>  Starting a Catalogue Service <<<<<<<<<<<<<"
systemctl enable catalogue
systemctl start catalogue

echo ">>>>>>  Installing Mongodb Client Shell <<<<<<<<<<<<<"
yum install mongodb-org-shell -y

echo ">>>>>>   Load  a Cataloguie Schema  <<<<<<<<<<<<<"
mongo --host mongodb-dev.pdevopst74.online </app/schema/catalogue.js


