#!/bin/bash

# Define your domain and desired IP address
DOMAIN="nvtest.io"
[ ! -f "./ip_address" ] && echo "Error: ./ip_address file does not exist." && exit 1
NEW_IP="$(cat ./ip_address)"

# Find the record ID for the A record
RECORD_IDS=$(doctl compute domain records list nvtest.io | grep -v "SOA" | grep -v "juice-shop" | grep -vi "crapi" | grep "A" | awk '{print $1}')

if [ -z "$RECORD_IDS" ]; then
  echo "A record not found for $DOMAIN."
  exit 1
fi

for RECORD_ID in $RECORD_IDS; do
  # Update the A record with the new IP address
  doctl compute domain records update $DOMAIN --record-id $RECORD_ID --record-data $NEW_IP
done
echo "A record updated successfully."
doctl compute domain records list nvtest.io 