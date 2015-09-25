#!/usr/bin/env bash

if [ $# -eq 2 ] ; then
    PROJECT_NAME=$1
    MY_DOC_ROOT=$2
    echo creating http://$PROJECT_NAME.local/ ...
else
    echo -e "Hi, what's your project name?"
    read PROJECT_NAME
    echo "OK, project name is '$PROJECT_NAME', so I going to create vhost http://$PROJECT_NAME.local"
    echo -e "Could you please specify document root?"
    read MY_DOC_ROOT
fi

if [ -d $MY_DOC_ROOT ]; then
	echo "Directory exists"
else
	echo "Directory does not exists: $MY_DOC_ROOT"
	exit 1
fi


# making host config
sudo chmod -R 777 /etc/apache2/sites-available/

touch /etc/apache2/sites-available/$PROJECT_NAME.local.conf
echo "
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot $MY_DOC_ROOT
        ServerName $PROJECT_NAME.local
        ServerAlias www.$PROJECT_NAME.local

        <Directory $MY_DOC_ROOT>
            Order allow,deny
            Allow from all
            Require all granted
            Options +Indexes +FollowSymLinks +ExecCGI
            AllowOverride All AuthConfig FileInfo
        </Directory>

        ErrorLog /var/log/apache2/error.log
        CustomLog /var/log/apache2/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/$PROJECT_NAME.local.conf

echo config created /etc/apache2/sites-available/$PROJECT_NAME.local.conf

cat /etc/apache2/sites-available/$PROJECT_NAME.local.conf

sudo chmod -R 777 /etc/apache2/sites-available/
sudo a2ensite $PROJECT_NAME.local.conf

# changing hosts
sudo sh -c "echo '127.0.0.1 $PROJECT_NAME.local' >> /etc/hosts"

sudo service apache2 restart

lynx http://$PROJECT_NAME.local/

