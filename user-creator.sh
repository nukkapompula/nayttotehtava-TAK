#!/bin/bash
while IFS="," read -r firstName lastName password group
do
    echo $firstName
    echo $lastName
    echo $password
    echo $group
    echo ""
done < <(tail -n +2 $1)