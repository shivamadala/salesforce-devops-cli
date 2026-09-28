#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Org Information"
echo "======================================"

echo "Checking Salesforce CLI..."
sf --version

echo ""
echo "Displaying target Salesforce org..."

sf org display \
  --target-org "$SF_USERNAME"

echo ""
echo "Listing authenticated Salesforce orgs..."

sf org list

echo ""
echo "Org information check completed successfully."