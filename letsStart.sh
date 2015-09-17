#!/bin/bash
clear

DEBIAN_FRONTEND=noninteractive sudo apt-get --force-yes -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

export LANGUAGE=en
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

sudo locale-gen en_US.UTF-8
sudo update-locale en_US


sudo aptitude update
clear
sudo aptitude install software-properties-common python-software-properties -y
clear
sudo aptitude install subversion
clear
sudo aptitude install curl
clear
sudo aptitude install git
clear
sudo aptitude install vim
clear
sudo aptitude install mc
clear
sudo aptitude install lynx-cur

# APACHE

clear
sudo aptitude install apache2
clear
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

# MYSQL

clear
sudo aptitude install mysql-server php5-mysql
clear
sudo mysql_install_db
# sudo mysql_secure_installation

# PHP

clear
sudo aptitude install software-properties-common
clear
sudo aptitude install python-software-properties
clear
sudo aptitude install php5 libapache2-mod-php5 php5-mcrypt
clear
sudo service apache2 restart
clear
sudo aptitude install php5-cgi
clear
sudo aptitude install php5-cli
clear
sudo aptitude install php-apc
clear
sudo aptitude install php5-common
clear
sudo aptitude install php5-curl
clear
sudo aptitude install php5-dbg
clear
sudo aptitude install php5-gd
clear
sudo aptitude install php5-gmp
clear
sudo aptitude install php5-mysql
clear
sudo aptitude install php5-odbc
clear
sudo aptitude install php5-pgsql
clear
sudo aptitude install php5-geoip
clear
sudo aptitude install php5-imagick
clear
sudo aptitude install php5-imap
clear
sudo aptitude install php5-mcrypt
clear
sudo aptitude install php5-memcache
clear
sudo aptitude install php5-memcached
clear
# Conflicts: php5-mysql but 5.5.9+dfsg-1ubuntu4.11 is to be installed.
# sudo aptitude install php5-mysqlnd
clear
# sudo aptitude install php5-xcache
clear
sudo aptitude install php5-xdebug

sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
sudo mv composer.phar /usr/local/bin

sudo chmod -R 755 /var/www
touch /var/www/html/index.php
echo  "<?php phpinfo(); ?>" > /var/www/html/index.php 
rm /var/www/html/index.html
sudo service apache2 restart
#lynx http://localhost/ # should show php info

# TUNING LOCAL ENV

echo 'export LC_ALL=en_US.UTF-8' >> ~/.bash_profile
echo 'export LANG=en_US.UTF-8' >> ~/.bash_profile
echo 'export LANGUAGE=en' >> ~/.bash_profile
echo 'export PS1="\e[0;35m[\u@\h \W]\$ \e[m "' >> ~/.bash_profile
echo 'alias composer="php /usr/local/bin/composer"' >> ~/.bash_profile
echo 'alias mc="mc -b"' >> ~/.bash_profile

# VIRTUAL HOSTS

# making host config
ln -s /vagrant/* /var/www
sudo chmod -R 755 /etc/apache2/sites-available/
sudo cp ./example.local.conf /etc/apache2/sites-available/example.local.conf
sudo chmod -R 755 /etc/apache2/sites-available/
sudo a2ensite example.local.conf

# making docroot with test ihdex.html
mkdir /var/www/example
mkdir /var/www/example/htdocs
touch /var/www/example/htdocs/index.html
sudo chmod -R 755 /var/www/example
echo 'example.local reporting in' > /var/www/example/htdocs/index.html

# changing hosts
sudo sh -c "echo '127.0.0.1 example.local' >> /etc/hosts"

sudo service apache2 restart

# FINISHING

clear
php5 -v
echo "

Everything's installed, boss. Re-login, please.

"
