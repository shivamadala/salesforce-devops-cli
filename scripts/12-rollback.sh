#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Metadata Rollback"
echo "======================================"

TARGET_ORG="${TARGET_ORG:-$SF_USERNAME}"
MANIFEST_FILE="${MANIFEST_FILE:-manifest/package.xml}"
WAIT_TIME="${WAIT_TIME:-30}"

ROLLBACK_COMMIT="$1"

if [ -z "$ROLLBACK_COMMIT" ]; then
    echo "ERROR: Git commit is required."
    echo ""
    echo "Usage:"
    echo "./scripts/12-rollback.sh <commit-id>"
    echo ""
    echo "Example:"
    echo "./scripts/12-rollback.sh abc1234"
    exit 1
fi

if [ ! -f "$MANIFEST_FILE" ]; then
    echo "ERROR: Manifest file not found:"
    echo "$MANIFEST_FILE"
    exit 1
fi

echo "Target Org      : $TARGET_ORG"
echo "Rollback Commit : $ROLLBACK_COMMIT"
echo "Manifest        : $MANIFEST_FILE"

echo ""
echo "Current Git commit:"
git rev-parse HEAD

echo ""
echo "Requested rollback commit:"
git rev-parse "$ROLLBACK_COMMIT"

echo ""
echo "WARNING: This will restore the source to the selected"
echo "known-good Git version and deploy it to Salesforce."

read -p "Type ROLLBACK to continue: " CONFIRM

if [ "$CONFIRM" != "ROLLBACK" ]; then
    echo "Rollback cancelled."
    exit 1
fi

echo ""
echo "Fetching latest Git information..."

git fetch --all

echo ""
echo "Checking out rollback version..."

git checkout "$ROLLBACK_COMMIT"

echo ""
echo "Current commit after checkout:"
git rev-parse HEAD

echo ""
echo "Starting Salesforce rollback deployment..."

sf project deploy start \
  --manifest "$MANIFEST_FILE" \
  --target-org "$TARGET_ORG" \
  --test-level RunLocalTests \
  --wait "$WAIT_TIME"

echo ""
echo "======================================"
echo " Rollback Deployment Completed"
echo "======================================"

echo ""
echo "IMPORTANT:"
echo "Review the Salesforce deployment result"
echo "and restore the working branch as required."