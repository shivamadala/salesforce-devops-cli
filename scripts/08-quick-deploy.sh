#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Quick Deploy"
echo "======================================"

TARGET_ORG="${TARGET_ORG:-$SF_USERNAME}"

if [ -z "$VALIDATION_ID" ]; then
    echo "ERROR: VALIDATION_ID is not set."
    echo ""
    echo "Usage:"
    echo "VALIDATION_ID=<deployment-job-id> ./scripts/08-quick-deploy.sh"
    exit 1
fi

echo "Target Org    : $TARGET_ORG"
echo "Validation ID : $VALIDATION_ID"

echo ""
echo "Starting Salesforce Quick Deploy..."

sf project deploy quick \
  --job-id "$VALIDATION_ID" \
  --target-org "$TARGET_ORG"

echo ""
echo "======================================"
echo " Quick Deploy Successful"
echo "======================================"