#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Authentication"
echo "======================================"

echo "Salesforce CLI version:"
sf --version

echo ""
echo "Authenticating to Salesforce..."

sf org login jwt \
  --username "$SF_USERNAME" \
  --jwt-key-file "$SF_JWT_KEY_FILE" \
  --client-id "$SF_CLIENT_ID" \
  --instance-url "$SF_INSTANCE_URL"

echo ""
echo "Authentication successful."

echo ""
echo "Authenticated Org Details:"

sf org display \
  --target-org "$SF_USERNAME"