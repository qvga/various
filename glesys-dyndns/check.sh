#!/bin/bash

source .env

myip=$(dig +short myip.opendns.com @resolver1.opendns.com)
dnsip=$(dig +short "$HOST" @resolver1.opendns.com)

echo "My IP: ${myip}  DNS IP: ${dnsip}"

if [[ "$myip" != "$dnsip" ]]; then
   echo "IP changed: ${newip}"
   curl -X POST --basic -u cl22302:nYZgF0YGD36JXJbrWFtF5wVKlSIFolbLteMOpKuB --data-urlencode "recordid=${RECORD_ID}" --data-urlencode "data=${myip}" https://api.glesys.com/domain/updaterecord
   echo "My IP: ${myip}  DNS IP: ${dnsip}" | mail -s '[ALERT] IP changed' "$MAILTO"
fi