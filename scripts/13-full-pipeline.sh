#!/bin/bash

set -e

echo "=============================================="
echo " Salesforce CI/CD Full Deployment Pipeline"
echo "=============================================="

# ------------------------------------------------
# Configuration
# ------------------------------------------------

TARGET_ORG="${TARGET_ORG:-$SF_USERNAME}"
MANIFEST_FILE="${MANIFEST_FILE:-manifest/package.xml}"
TEST_LEVEL="${TEST_LEVEL:-RunLocalTests}"
WAIT_TIME="${WAIT_TIME:-30}"

echo ""
echo "Target Org : $TARGET_ORG"
echo "Manifest   : $MANIFEST_FILE"
echo "Test Level : $TEST_LEVEL"

# ------------------------------------------------
# Step 1 - Salesforce CLI
# ------------------------------------------------

echo ""
echo "=============================================="
echo "STEP 1: Salesforce CLI"
echo "=============================================="

sf --version

# ------------------------------------------------
# Step 2 - Authentication
# ------------------------------------------------

echo ""
echo "=============================================="
echo "STEP 2: Authentication"
echo "=============================================="

./scripts/01-authenticate.sh

# ------------------------------------------------
# Step 3 - Org Information
# ------------------------------------------------

echo ""
echo "=============================================="
echo "STEP 3: Verify Target Org"
echo "=============================================="

./scripts/02-org-info.sh

# ------------------------------------------------
# Step 4 - Git Comparison
# ------------------------------------------------

echo ""
echo "=============================================="
echo "STEP 4: Git Change Analysis"
echo "=============================================="

./scripts/10-compare-git.sh

# ------------------------------------------------
# Step 5 - Metadata Validation
# ------------------------------------------------

echo ""
echo "=============================================="
echo "STEP 5: Salesforce Validation"
echo "=============================================="

MANIFEST_FILE="$MANIFEST_FILE" \
TARGET_ORG="$TARGET_ORG" \
TEST_LEVEL="$TEST_LEVEL" \
WAIT_TIME="$WAIT_TIME" \
./scripts/05-validate.sh

# ------------------------------------------------
# Step 6 - Deployment
# ------------------------------------------------

echo ""
echo "=============================================="
echo "STEP 6: Salesforce Deployment"
echo "=============================================="

MANIFEST_FILE="$MANIFEST_FILE" \
TARGET_ORG="$TARGET_ORG" \
TEST_LEVEL="$TEST_LEVEL" \
WAIT_TIME="$WAIT_TIME" \
./scripts/06-deploy.sh

# ------------------------------------------------
# Step 7 - Apex Tests
# ------------------------------------------------

echo ""
echo "=============================================="
echo "STEP 7: Apex Tests"
echo "=============================================="

TARGET_ORG="$TARGET_ORG" \
TEST_LEVEL="$TEST_LEVEL" \
WAIT_TIME="$WAIT_TIME" \
./scripts/07-run-tests.sh

# ------------------------------------------------
# Pipeline completed
# ------------------------------------------------

echo ""
echo "=============================================="
echo " Salesforce CI/CD Pipeline SUCCESS"
echo "=============================================="

echo ""
echo "Target Org:"
echo "$TARGET_ORG"

echo ""
echo "Deployment completed successfully."