#!/bin/bash

set -e

echo "======================================"
echo " Git / Salesforce Change Comparison"
echo "======================================"

BASE_BRANCH="${BASE_BRANCH:-main}"

echo "Current branch:"
git branch --show-current

echo ""
echo "Base branch:"
echo "$BASE_BRANCH"

echo ""
echo "======================================"
echo " Git Working Tree"
echo "======================================"

git status --short

echo ""
echo "======================================"
echo " Changed Files"
echo "======================================"

git diff --name-status

echo ""
echo "======================================"
echo " Changes Compared With $BASE_BRANCH"
echo "======================================"

git fetch origin "$BASE_BRANCH"

git diff --name-status "origin/$BASE_BRANCH...HEAD"

echo ""
echo "======================================"
echo " Salesforce Metadata Changes"
echo "======================================"

git diff --name-only "origin/$BASE_BRANCH...HEAD" \
  | grep -E '\.(cls|trigger|xml|flow|permissionset|profile-meta\.xml)$' \
  || echo "No Salesforce metadata changes detected."

echo ""
echo "Comparison completed."