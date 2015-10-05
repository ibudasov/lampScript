#!/bin/bash
clear

export LANGUAGE=en
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

sudo locale-gen en_US.UTF-8
sudo update-locale en_US


sudo aptitude update
clear
sudo aptitude install subversion -y
clear
sudo aptitude install curl -y
clear
sudo aptitude install git -y
clear
sudo aptitude install vim -y
clear
sudo aptitude install mc -y
clear
sudo aptitude install lynx-cur -y

# APACHE

clear
sudo aptitude install apache2 -y
clear
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

# MYSQL

clear
sudo aptitude install mysql-server -y
sudo aptitude install php5-mysql  -y
clear
sudo mysql_install_db
# sudo mysql_secure_installation

# PHP

clear
sudo aptitude install software-properties-common -y
clear
sudo aptitude install python-software-properties -y
clear
sudo aptitude install php5 -y
clear
sudo aptitude install libapache2-mod-php5 -y
clear
sudo aptitude install php5-mcrypt -y
clear
sudo service apache2 restart
clear
sudo aptitude install php5-cgi -y
clear
sudo aptitude install php5-cli -y
clear
sudo aptitude install php-apc -y
clear
sudo aptitude install php5-common -y
clear
sudo aptitude install php5-curl -y
clear
sudo aptitude install php5-dbg -y
clear
sudo aptitude install php5-gd -y
clear
sudo aptitude install php5-gmp -y
clear
sudo aptitude install php5-mysql -y
clear
sudo aptitude install php5-odbc -y
clear
sudo aptitude install php5-pgsql -y
clear
sudo aptitude install php5-geoip -y
clear
sudo aptitude install php5-imagick -y
clear
sudo aptitude install php5-imap -y
clear
sudo aptitude install php5-mcrypt -y
clear
sudo aptitude install php5-memcache -y
clear
sudo aptitude install php5-memcached -y
clear
sudo aptitude install phpunit -y
clear
sudo aptitude install httpie -y
clear
# Conflicts: php5-mysql but 5.5.9+dfsg-1ubuntu4.11 is to be installed.
# sudo aptitude install php5-mysqlnd
clear
# sudo aptitude install php5-xcache
clear
sudo aptitude install php5-xdebug -y

sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
#sudo mv composer.phar /usr/local/bin

sudo chmod -R 777 /var/www
touch /var/www/html/index.php
echo  "<?php phpinfo(); ?>" > /var/www/html/index.php 
rm /var/www/html/index.html

sudo a2enmod rewrite
sudo a2enmod headers
sudo php5enmod mcrypt
sudo sh -c "echo 'ServerName localhost' >> /etc/apache2/apache2.conf"
sudo service apache2 restart

sudo sh -c "echo 'export APACHE_RUN_USER=vagrant' >> /etc/apache2/envvars"
sudo sh -c "echo 'export APACHE_RUN_GROUP=vagrant' >> /etc/apache2/envvars"

#lynx http://localhost/ # should show php info

# TUNING LOCAL ENV

echo 'export LC_ALL=en_US.UTF-8' >> ~/.bash_profile
echo 'export LANG=en_US.UTF-8' >> ~/.bash_profile
echo 'export LANGUAGE=en' >> ~/.bash_profile
# 35 = magenta
# 36 = cyan
echo 'export PS1="\[\e[35m\]me@\h\[\e[m\] \w \[\e[31m\]\\$\[\e[m\] "' >> ~/.bash_profile
echo 'alias composer="php /usr/local/bin/composer"' >> ~/.bash_profile
echo 'alias mc="mc -b"' >> ~/.bash_profile
echo 'alias ls="ls -gat"' >> ~/.bash_profile


# SYMFONY STUFF
clear
sudo curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony
sudo sh -c "echo 'date.timezone = \"Europe/Amsterdam\"' >> /etc/php5/cli/php.ini"
sudo sh -c "echo 'xdebug.max_nesting_level=250' >> /etc/php5/cli/php.ini"
sudo aptitude install php5-intl -y

# NODEJS STUFF
clear
sudo apt-get update
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo npm install -g less


# SWAP for composer mostly
clear
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1

# VIRTUAL HOSTS

# making docroot with test ihdex.html
sudo chmod -R 777 /var/www
mkdir /var/www/example
sudo chmod -R 777 /var/www/example
mkdir /var/www/example/htdocs
sudo chmod -R 777 /var/www/example
touch /var/www/example/htdocs/index.html
echo 'example.local reporting in' > /var/www/example/htdocs/index.html

wget https://raw.githubusercontent.com/ibudasov/lampScript/master/addVhost.sh
./addVhost.sh example /var/www/example

# FINISHING

clear
php5 -v
echo "

Everything's installed, boss. Re-login, please.

"
