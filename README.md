# lapmScript

Use this script for simplify setting up LAMP stack installation on Ubuntu systems.

### Usage

Install for your host OS:

- http://www.virtualbox.org/
- https://www.vagrantup.com/

Then run commands:

- vagrant init ubuntu/trusty64
- vagrant up
- vagrant ssh
- Inside Vagrant run this script /vagrant/lampScript/makeInstall.sh

### Post-install

change vagrantfile:

- config.vm.network :forwarded_port, guest: 80, host: 8888
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

### Included:

- PHP (with lots of modules)
- MySQL
- Apache (with vhosts)
- Vim, mc, git, svn, etc...

BEWARE: versions of installing software strongly depends on your OS version. 

### adding vhost (newschool)

- /vagrant/lampScript/addVhost.sh

### making host config (oldschool)

- ln -s /vagrant/* /var/www
- sudo cp /etc/apache2/sites-available/example.local.conf /etc/apache2/sites-available/example.local.conf
- vim /etc/apache2/sites-available/example.local.conf
- sudo chmod -R 777 /etc/apache2/sites-available/
- sudo a2ensite example.local.conf

### changing hosts (oldschool)

- sudo sh -c "echo '127.0.0.1 example.local' >> /etc/hosts"
- sudo service apache2 restart

### Got trouble?

- sudo tail /var/log/apache2/error.log
- tailf /vagrant/marathon/deploy/var/logs/development.log
