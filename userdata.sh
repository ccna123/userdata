# -----------------API SERVER----------------- 
#!/bin/bash
touch ~/.bashrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
source ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
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

# -----------------Finding where java is installed----------------- 
ls -l /usr/lib/jvm/

# -----------------Config file for maven----------------- 
nano ~/.mavenrc


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

# -----install java 21 and start app-----
sudo yum install java-21-amazon-corretto-headless
java -jar jar_app_name

# -----remove java 21-----
sudo yum remove java-21-amazon-corretto-headless

# -----install codeDeploy agent-----
sudo yum install -y https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/codedeploy-agent.noarch.rpm
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
# [Unit]
# Description=My Java Spring Application
# After=network.target
# StartLimitIntervalSec=0

# [Service]
# User=ec2-user
# WorkingDirectory=/home/ec2-user/spring_app
# ExecStart=/usr/bin/java -jar your-app.jar > /var/log/spring_app_log.log 2>&1
# Restart=always
# RestartSec=1
# SuccessExitStatus=143
# User=ec2-user

# [Install]
# WantedBy=multi-user.target

# -----config cloudwatch agent-----
sudo yum install amazon-cloudwatch-agent -y
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json

# -----start ssm session-----
aws ssm start-session \
  --target インスタンスID \
  --document-name AWS-StartPortForwardingSessionToRemoteHost \
  --parameters '{"host":["RDSエンドポイント"],"portNumber":["3306"], "localPortNumber":["任意ポート"]}' \
  --profile default &

aws ssm describe-sessions --state Active
aws ssm terminate-session --session-id <session id>

{
    "Sessions": [
        {
            "SessionId": "example-session-id-1",
            "Target": "i-0123456789abcdef0",
            "Status": "Active"
        },
        {
            "SessionId": "example-session-id-2",
            "Target": "i-0987654321fedcba0",
            "Status": "Active"
        }
    ]
}
