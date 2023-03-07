#!/bin/bash

PORT=80
ALB_DNS_NAME=63.33.211.57

# Make an HTTP request to the application through the ALB
RESPONSE=$(curl -v -w '%{http_code}' http://$ALB_DNS_NAME:$PORT/ -o /dev/null)
echo "$RESPONSE"

# Check the HTTP status code of the response
if [ "$RESPONSE" -eq 200 ]; then
  echo "HTTP request successful"
else
  echo "HTTP request failed with status code $RESPONSE"
fi

