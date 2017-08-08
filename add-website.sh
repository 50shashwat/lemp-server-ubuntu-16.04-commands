echo "Creating $1 website"
sudo mkdir -p /var/www/$1/public_html
sudo chown -R www-data:www-data /var/www/$1/public_html
sudo chmod -R 755 /var/www/$1/public_html/
echo "<html><head><title>Working</title></head><body><h2>Working</h2></body></html>" > /var/www/$1/public_html/index.html
sudo echo "server {\n        listen 80;\n        listen [::]:80;\n       root /var/www/$1/public_html;\n        index index.php index.html index.htm index.nginx-debian.html;\n        server_name $1 www.$1;\n        location / {\n                try_files \$uri \$uri/ /index.php?args;\n        }\n		 location ~ \\.php\$ {\n        include snippets/fastcgi-php.conf;\n        fastcgi_pass unix:/run/php/php7.0-fpm.sock;\n    }\n    location ~ /\\.ht {\n        deny all;\n    }\n}\n" > /etc/nginx/sites-available/$1
sudo ln -s /etc/nginx/sites-availabel/$1 /etc/nginx/sites-enabled/
sudo systemctl reload nginx
