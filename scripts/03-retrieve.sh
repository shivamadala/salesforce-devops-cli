#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Metadata Retrieve"
echo "======================================"

echo "Target Org:"
echo "$SF_USERNAME"

echo ""
echo "Retrieving metadata using package.xml..."

sf project retrieve start \
  --manifest manifest/package.xml \
  --target-org "$SF_USERNAME" \
  --wait 30

echo ""
echo "Metadata retrieve completed successfully."

echo ""
echo "Git status after retrieve:"

git status --short