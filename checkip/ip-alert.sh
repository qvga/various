#!/bin/bash

source .env

newip=$(dig +short myip.opendns.com @resolver1.opendns.com)
oldip=$(cat ip.txt)

echo "IP: ${newip}"

if [[ "$newip" != "$oldip" ]]; then
   echo "NEW IP: ${newip}"
   echo "${oldip} -> ${newip}" | mail -s '[IP-ALERT] IP changed' "$MAILTO"
   echo "$newip" > ip.txt
fi