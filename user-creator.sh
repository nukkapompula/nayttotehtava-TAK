#!/bin/bash
while IFS="," read -r firstName lastName password group
do
        echo "$firstName.$lastName"
        echo $password
        echo $group
        echo ""
done < <(tail -n +2 $1)

# sudo useradd -mg $firstName.$lastName $group
# sudo chpasswd $firstName.$lastName:$password