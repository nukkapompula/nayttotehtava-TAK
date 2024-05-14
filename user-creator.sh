#!/bin/bash

function create_html {
sudo touch /home/$1.$2/public_html/index.html
sudo chmod a+rwx /home/$1.$2/public_html/index.html
sudo cat > /home/$1.$2/public_html/index.html << EOF
<!DOCTYPE html>
<html lang="en">
        <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Index</title>
        </head>
        <body>
                <p>Tämän sivun omistaa käyttäjä <b>$1 $2</b>.</p>
        </body>
</html>
EOF
}

while IFS="," read -r firstName lastName password group
do
        sudo groupadd testi
        sudo useradd -m $firstName.$lastName
        sudo usermod -c "$firstName $lastName $group" $firstName.$lastName
        sudo usermod -g testi $firstName.$lastName
        echo "$firstName.$lastName:$password" | sudo chpasswd
        sudo chmod -R a+rwx /home/$firstName.$lastName
#        sudo chmod -R ug+x /home/$firstName.$lastName
#        sudo chmod -R o-rwx /home/$firstName.$lastName
        sudo mkdir /home/$firstName.$lastName/public_html
        create_html $firstName $lastName
done < <(tail -n +2 $1)