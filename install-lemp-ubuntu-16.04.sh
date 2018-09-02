#!/bin/bash

sudo apt-get update
sudo apt-get -y install nginx
psswd="$(openssl rand -base64 12)"
DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password $psswd'
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again $psswd'
sudo apt-get -y install mysql-server-5.7
sudo systemctl start mysql
sudo ufw allow 'Nginx HTTP'
sudo apt-get install -y php-fpm php-mysql php-mbstring php-cli
sudo systemcl reload nginx
php_version="$(ls /etc/php/)"
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/$php_version/fpm/php.ini
echo "Enabling php on server..."
sed -i 's/index index.html/index index.php index.html/g' /etc/nginx/sites-available/default
sed -i 's/try_files $uri $uri\/ =404/try_files $uri $uri\/ \/index.php?$args/g' /etc/nginx/sites-available/default
echo "Enabling routes with get request on main domain..."
sed -i 's/#location ~ \\.php$ {/location ~ \\.php$ {\n\t include snippets\/fastcgi-php.conf;\n\t fastcgi_pass unix:\/var\/run\/php\/'"$php_version"'-fpm.sock;\n\t}/g' /etc/nginx/sites-available/default
echo -e "$psswd" >> /.mysql_pass

