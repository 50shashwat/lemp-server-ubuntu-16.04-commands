#!/bin/bash

apt install wget -y
./add-website.sh $1
service nginx start && service mysql start && service php-fpm start
cd /var/www/$1
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/* public_html/
rm wordpress/ -r
rm latest.tar.gz
echo "CREATING DATABASE"
mysql_pass="$(cat /.mysql_pass)"
dbname="$(echo ${1/./_} )"
dbuser="$(echo $dbname'_user' )"
dbhost="localhost"
dbpsswd="$(openssl rand -base64 12)"
mysql -h $dbhost -u  root -password=$mysql_pass -Bse "CREATE DATABASE $dbname; GRANT ALL PRIVILEGES ON dbname.* TO  '$dbuser'@'$dbhost' IDENTIFIED BY '$dbpsswd'"
chmod 755 /var/www/$1/public_html -R
chown www-data:www-data /var/www/$1/public_html -R
echo -e "Use DBNAME: $dbname\nDBPASS: $dbpsswd\nDBUSER: $dbuser\nDBHOST: $dbhost;"


