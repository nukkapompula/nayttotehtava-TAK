#!/bin/bash

function create_html {
        touch /home/$1.$2/public_html/index.html
        cat > index.html << EOF
        <!DOCTYPE html>
        <html lang="en">
                <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Index</title>
                </head>
                <body>
                        <p>Tämän sivun omistaa $1 $2.</p>
                </body>
        </html>
EOF
}

while IFS="," read -r firstName lastName password group
do
        sudo useradd -mg $firstName.$lastName $group
        sudo chpasswd $firstName.$lastName:$password
        mkdir /home/$firstName.$lastName/public_html
        create_html $firstName $lastName
        chmod -R ug+x $firstName.$lastName
        chmod -R o-rwx $firstName.$lastName
done < <(tail -n +2 $1)