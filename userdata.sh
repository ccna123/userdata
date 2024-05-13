# -----------------API SERVER----------------- 
#!/bin/bash
sudo yum update -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install nodenvm install --lts
sudo yum install git -y
npm install -g pm2 -y
git clone https://github.com/ccna123/appointment.git
chmod 700 -R appointment/


# -----------------HTTP SERVER AMAZON LINUX----------------- 
#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
chown apache /var/www/html/index.html
sudo systemctl enable httpd
sudo systemctl start httpd

# -----------------HTTP SERVER UBUNTU----------------- 
sudo apt install apache2
sudo systemctl status apache2

# -----------------MYSQL----------------- 
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
sudo yum localinstall -y mysql57-community-release-el7-8.noarch.rpm
sudo yum install -y mysql-community-server

# -----get root password-----
sudo grep 'temporary password' /var/log/mysqld.log


# -----change password for root-----
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password123!';

# ----create user 'sam' for specific database that connect from localhost----
# lotr: database name
# sam : user for lotr database
# MyNewPass1: password
# this user access database only from localhost
CREATE USER 'mit'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON lotr.* TO 'mit'@'localhost';


# ----create user 'frodo' for specific database from anywhere----
CREATE USER 'frodo'@'%' IDENTIFIED WITH mysql_native_password BY 'MyNewPass1!';
GRANT ALL PRIVILEGES ON *.* TO 'frodo'@'%';

# ----run below command to load env into prisma after fixing env file----
npx prisma generate

# -----install java 17 and start app-----
sudo dnf install java-17-amazon-corretto -y
java -jar jar_app_name

# -----install codeDeploy agent-----
sudo yum install -y ruby
wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

sudo service codedeploy-agent status


# -----register spring app as service-----
[Unit]
Description=My Java Spring Application
After=network.target
StartLimitIntervalSec=0

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/spring_app
ExecStart=/usr/bin/java -jar your-app.jar
Restart=always
RestartSec=1
SuccessExitStatus=143
User=ec2-user

[Install]
WantedBy=multi-user.target