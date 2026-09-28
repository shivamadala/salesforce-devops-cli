#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Package Retrieve"
echo "======================================"

# Default values
MANIFEST_FILE="${MANIFEST_FILE:-manifest/package.xml}"
TARGET_ORG="${TARGET_ORG:-$SF_USERNAME}"

echo "Manifest : $MANIFEST_FILE"
echo "Target Org: $TARGET_ORG"

# Check that manifest exists
if [ ! -f "$MANIFEST_FILE" ]; then
    echo "ERROR: Manifest file not found: $MANIFEST_FILE"
    exit 1
fi

echo ""
echo "Retrieving metadata package..."

sf project retrieve start \
  --manifest "$MANIFEST_FILE" \
  --target-org "$TARGET_ORG" \
  --wait 30

echo ""
echo "Package retrieve completed successfully."

echo ""
echo "Retrieved files:"
git status --short