#!/bin/bash

echo "OPTIONAL PACKAGES"
echo "Installing Zip..."
sudo apt-get install -y zip unzip
echo "PHP Packages ..."
sudo apt install php-zip php-curl php-xsl php-xml php-gd php-mbstring -y
