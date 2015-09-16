#!/bin/bash
clear
sudo apt-get update
sudo apt-get install software-properties-common python-software-properties -y
sudo apt-get install subversion -y
sudo apt-get install curl -y
sudo apt-get install git -y
sudo apt-get install vim -y
sudo apt-get install mc -y
sudo apt-get install lynx-cur

# APACHE

sudo apt-get install apache2 -y
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

# MYSQL

sudo apt-get install mysql-server php5-mysql -y
sudo mysql_install_db
# sudo mysql_secure_installation

# PHP

sudo apt-get install software-properties-common -y
sudo apt-get install python-software-properties -y
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
sudo service apache2 restart
sudo aptitude install php5-cgi -y
sudo aptitude install php5-cli -y
sudo apt-get install php-apc -y
sudo aptitude install php5-common -y
sudo aptitude install php5-curl -y
sudo aptitude install php5-dbg -y
sudo aptitude install php5-gd -y
sudo aptitude install php5-gmp -y
sudo aptitude install php5-mysql -y
sudo aptitude install php5-odbc -y
sudo aptitude install php5-pgsql -y
sudo aptitude install php5-geoip -y
sudo aptitude install php5-imagick -y
sudo aptitude install php5-imap -y
sudo aptitude install php5-mcrypt -y
sudo aptitude install php5-memcache -y
sudo aptitude install php5-memcached -y
sudo aptitude install php5-mysqlnd -y
sudo aptitude install php5-xcache -y
sudo aptitude install php5-xdebug -y

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

lynx http://localhost/
sudo chmod -R 777 /var/www
touch /var/www/index.php
echo  "<?php phpinfo(); ?>" > /var/www/index.php 
rm /var/www/index.html
lynx http://localhost/ # should show php info
sudo service apache2 restart


