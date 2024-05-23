#!/bin/bash

function create_html {
cat > ./public_html/index.html << EOF
<!DOCTYPE html>
<html lang="en">
        <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Index</title>
        </head>
        <body>
                <p>This page belongs to user <b>$1.$2</b></p>
        </body>
</html>
EOF
}

function create_conf {
cat > ./$1-$2.conf << EOF
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName $1-$2
        ServerAlias www.$1-$2
        DocumentRoot /var/www/$1-$2
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
}

while IFS="," read firstName lastName password group
do
        sudo groupadd $group
        sudo useradd -m $firstName.$lastName
        sudo usermod -c "$firstName $lastName $group" $firstName.$lastName
        sudo usermod -g $group $firstName.$lastName
        sudo usermod -a -G $group www-data
        sudo usermod -a -G $group $USER
        echo "$firstName.$lastName:$password" | sudo chpasswd
        mkdir public_html
        create_html $firstName $lastName
        sudo mkdir /var/www/$firstName-$lastName
        sudo mv -t /var/www/$firstName-$lastName public_html
        sudo chgrp -R $group /var/www/$firstName-$lastName
        sudo chmod -R ug+rwx,o-rwx /var/www/$firstName-$lastName
        create_conf $firstName $lastName
        sudo mv $firstName-$lastName.conf /etc/apache2/sites-available
        sudo a2ensite $firstName-$lastName.conf
done < <(tail -n +2 $1)
sudo systemctl restart apache2