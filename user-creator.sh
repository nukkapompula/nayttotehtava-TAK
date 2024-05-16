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
                <p>This page belongs to user <b>$1 $2</b>.</p>
        </body>
</html>
EOF
}

while IFS="," read firstName lastName password group
do
        sudo groupadd $group
        sudo useradd -m $firstName.$lastName
        sudo usermod -c "$firstName $lastName $group" $firstName.$lastName
        sudo usermod -g $group $firstName.$lastName
        sudo usermod -a -G $group $USER
        echo "$firstName.$lastName:$password" | sudo chpasswd
        mkdir public_html
        create_html $firstName $lastName
        sudo mv -t /home/$firstName.$lastName public_html
        sudo chmod -R ug+rwx,o-rwx /home/$firstName.$lastName
        sudo chgrp -R $group /home/$firstName.$lastName
done < <(tail -n +2 $1)