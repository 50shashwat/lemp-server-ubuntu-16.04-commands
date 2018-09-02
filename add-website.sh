#!/bin/bash

echo "Creating $1 website"
php_version="$(ls /etc/php/)"
sudo mkdir -p /var/www/$1/public_html
sudo chown -R www-data:www-data /var/www/$1/public_html
sudo chmod -R 755 /var/www/$1/public_html/
sudo echo -e "<html>\n\t<head>\n\t\t<title>Working</title>\n\t</head>\n\t<body>\n\t\t<h2>Working</h2>\n\t</body>\n</html>" > /var/www/$1/public_html/index.html
sudo echo -e "server {\n\t listen 80;\n\tlisten [::]:80;\n\troot /var/www/$1/public_html;\n\tindex index.php index.html index.htm index.nginx-debian.html;\n\tserver_name $1 www.$1;\n\tlocation / {\n\t\ttry_files \$uri \$uri/ /index.php?\$args;\n\t}\n\tlocation ~ \\.php\$ {\n\t\tinclude snippets/fastcgi-php.conf;\n\t\tfastcgi_pass unix:/run/php/php"$php_version"-fpm.sock;\n\t}\n\tlocation ~ /\\.ht {\n\t\tdeny all;\n\t}\n}" > /etc/nginx/sites-available/$1
sudo ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/
sudo systemctl reload nginx
sudo service nginx reload
sudo service php$php_version-fpm reload
