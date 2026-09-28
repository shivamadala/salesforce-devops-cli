#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Destructive Deployment"
echo "======================================"

MANIFEST_FILE="${MANIFEST_FILE:-manifest/package.xml}"
DESTRUCTIVE_FILE="${DESTRUCTIVE_FILE:-manifest/destructiveChanges.xml}"
TARGET_ORG="${TARGET_ORG:-$SF_USERNAME}"
TEST_LEVEL="${TEST_LEVEL:-RunLocalTests}"
WAIT_TIME="${WAIT_TIME:-30}"

echo "Manifest          : $MANIFEST_FILE"
echo "Destructive File  : $DESTRUCTIVE_FILE"
echo "Target Org        : $TARGET_ORG"
echo "Test Level        : $TEST_LEVEL"

# Check files

if [ ! -f "$MANIFEST_FILE" ]; then
    echo "ERROR: Package manifest not found:"
    echo "$MANIFEST_FILE"
    exit 1
fi

if [ ! -f "$DESTRUCTIVE_FILE" ]; then
    echo "ERROR: Destructive changes file not found:"
    echo "$DESTRUCTIVE_FILE"
    exit 1
fi

echo ""
echo "WARNING: This deployment contains metadata deletion."
echo ""

read -p "Type DELETE to continue: " CONFIRM

if [ "$CONFIRM" != "DELETE" ]; then
    echo "Deployment cancelled."
    exit 1
fi

echo ""
echo "Starting destructive deployment..."

sf project deploy start \
  --manifest "$MANIFEST_FILE" \
  --pre-destructive-changes "$DESTRUCTIVE_FILE" \
  --target-org "$TARGET_ORG" \
  --test-level "$TEST_LEVEL" \
  --wait "$WAIT_TIME"

echo ""
echo "======================================"
echo " Destructive Deployment Completed"
echo "======================================"