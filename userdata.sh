-----------------API SERVER----------------- 
#!bin/bash
sudo yum update -y
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install node
sudo yum install git -y
git clone https://github.com/ccna123/harrypoter.git
chmod 700 -R harrypoter/
cd harrypoter
npm install
npm run dev

-----------------HTTP SERVER----------------- 
#!bin/bash
sudo yum update -y
sudo yum install httpd -y
chkconfig httpd on
echo $HOSTNAME > /var/www/html/index.html
chown apache /var/www/html/index.html
sudo systemctl start httpd