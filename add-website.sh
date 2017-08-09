echo "Creating $1 website"
sudo mkdir -p /var/www/$1/public_html
sudo chown -R www-data:www-data /var/www/$1/public_html
sudo chmod -R 755 /var/www/$1/public_html/
echo "<html><head><title>Working</title></head><body><h2>Working</h2></body></html>" > /var/www/$1/public_html/index.html
sudo echo "server {        listen 80;        listen [::]:80;       root /var/www/$1/public_html;        index index.php index.html index.htm index.nginx-debian.html;        server_name $1 www.$1;        location / {                try_files \$uri \$uri/ /index.php?args;        }		 location ~ \\.php\$ {        include snippets/fastcgi-php.conf;        fastcgi_pass unix:/run/php/php7.0-fpm.sock;    }    location ~ /\\.ht {        deny all;    }}" > /etc/nginx/sites-available/$1
sudo ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/
sudo systemctl reload nginx
