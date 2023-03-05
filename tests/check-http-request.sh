#!/bin/bash

PORT=8000
ALB_DNS_NAME=myapp-alb-1234567890.us-west-2.elb.amazonaws.com

# Make an HTTP request to the application through the ALB
RESPONSE=$(curl -I -w '%{http_code}' http://$ALB_DNS_NAME:$PORT/ -o /dev/null)
echo "$RESPONSE"

# Check the HTTP status code of the response
if [ "$RESPONSE" -eq 200 ]; then
  echo "HTTP request successful"
else
  echo "HTTP request failed with status code $RESPONSE"
fi

