#!/usr/bin/env bash

echo -e "Hi, what's your project name?"
read projectName
echo "OK, project name is '$projectName', so I going to create vhost http://$projectName.local"
echo -e "Could you please specify document root?"
read documentRoot

if [ -d $documentRoot ]; then
	echo "Directory exists"
else
	echo "Directory does not exists: $documentRoot"
	exit 1
fi

echo creating http://$projectName.local/ ...

# making host config
sudo chmod -R 777 /etc/apache2/sites-available/

touch /etc/apache2/sites-available/$projectName.local.conf
echo created config placeholder /etc/apache2/sites-available/$projectName.local.conf
echo "
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot $documentRoot
        ServerName $projectName.local
        ServerAlias www.$projectName.local

        <Directory $documentRoot>
                Order allow,deny
                Allow from all
                AllowOverride All
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/$projectName.local.conf

echo config populated /etc/apache2/sites-available/$projectName.local.conf

sudo chmod -R 777 /etc/apache2/sites-available/
sudo a2ensite $projectName.local.conf

# changing hosts
sudo sh -c "echo '127.0.0.1 $projectName.local' >> /etc/hosts"

sudo service apache2 restart

lynx http://$projectName.local/

