# lapmScript

Use this script for simplify setting up LAMP stack installation on Ubuntu systems.

# Usage

Install for your host OS:

- http://www.virtualbox.org/
- https://www.vagrantup.com/

Then run commands:

- vagrant init ubuntu/trusty64
- vagrant up
- vagrant ssh
- Inside Vagrant run this script /vagrant/lampScript/letsStart.sh

# Post-install

change vagrantfile:

- config.vm.network :forwarded_port, guest: 80, host: 8000
- config.vm.network :forwarded_port, guest: 3306, host: 3306
- vagrant reload
- edit your host OS /etc/hosts
- open in your host system http://localhost:8000

You can connect from your host OS to Vagrant's MySQL:

- mysql host — 127.0.0.1
- username — root
- password — “”
- database — “”
- port — 3306
- ssh host — localhost
- ssh user — vagrant 
- ssh password — vagrant
- ssh port — 2222

# Included:

- PHP (with lots of modules)
- MySQL
- Apache (with vhosts)
- Vim, mc, git, svn, etc...

BEWARE: versions of installing software strongly depends on your OS version. 

# VIRTUAL HOSTS

### making host config

- ln -s /vagrant/* /var/www
- sudo chmod -R 777 /etc/apache2/sites-available/
- sudo cp ./example.local.conf /etc/apache2/sites-available/example.local.conf # see example.local.conf in this repo
- sudo chmod -R 777 /etc/apache2/sites-available/
- sudo a2ensite example.local.conf

### making docroot with test ihdex.html

- mkdir /var/www/example
- mkdir /var/www/example/htdocs
- touch /var/www/example/htdocs/index.html
- sudo chmod -R 777 /var/www/example
- echo 'example.local reporting in' > /var/www/example/htdocs/index.html

### changing hosts

- sudo echo '127.0.0.1 example.local' >> /etc/hosts
- sudo service apache2 restart
