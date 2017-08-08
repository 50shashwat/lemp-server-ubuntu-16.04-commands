sudo apt-get update
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'
sudo apt-get install -y mysql-server
sudo apt-get install -y php-fpm php-mysql 
sudo systemcl reload nginx
echo "sudo nano /etc/php/7.0/fpm/php.ini \n Search For cgi.fix_pathinfo=0 "

