#!/bin/bash

PORT=8000
ALB_DNS_NAME=finalproject-alb-2143497004.eu-west-1.elb.amazonaws.com

# Make an HTTP request to the application through the ALB
curl -I -s http://$ALB_DNS_NAME:$PORT/

# Check the exit code of the curl command
if [ $? -eq 200 ]; then
  echo "HTTP request successful"
else
  echo "HTTP request failed"
fi

