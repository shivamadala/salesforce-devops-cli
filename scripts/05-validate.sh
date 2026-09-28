#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Deployment Validation"
echo "======================================"

# Default values
MANIFEST_FILE="${MANIFEST_FILE:-manifest/package.xml}"
TARGET_ORG="${TARGET_ORG:-$SF_USERNAME}"
TEST_LEVEL="${TEST_LEVEL:-RunLocalTests}"
WAIT_TIME="${WAIT_TIME:-30}"

echo "Manifest   : $MANIFEST_FILE"
echo "Target Org : $TARGET_ORG"
echo "Test Level : $TEST_LEVEL"
echo "Wait Time  : $WAIT_TIME minutes"

# Check manifest
if [ ! -f "$MANIFEST_FILE" ]; then
    echo "ERROR: Manifest file not found:"
    echo "$MANIFEST_FILE"
    exit 1
fi

echo ""
echo "Starting Salesforce deployment validation..."

sf project deploy start \
  --manifest "$MANIFEST_FILE" \
  --target-org "$TARGET_ORG" \
  --test-level "$TEST_LEVEL" \
  --dry-run \
  --wait "$WAIT_TIME"

echo ""
echo "======================================"
echo " Validation Successful"
echo "======================================"