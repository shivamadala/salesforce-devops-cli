#!/bin/bash

set -e

echo "======================================"
echo " Salesforce Apex Test Execution"
echo "======================================"

TARGET_ORG="${TARGET_ORG:-$SF_USERNAME}"
TEST_LEVEL="${TEST_LEVEL:-RunLocalTests}"
WAIT_TIME="${WAIT_TIME:-30}"

echo "Target Org : $TARGET_ORG"
echo "Test Level : $TEST_LEVEL"
echo "Wait Time  : $WAIT_TIME minutes"

echo ""

case "$TEST_LEVEL" in

  RunLocalTests)

    echo "Running all local/custom Apex tests..."

    sf apex run test \
      --target-org "$TARGET_ORG" \
      --test-level RunLocalTests \
      --wait "$WAIT_TIME" \
      --result-format human

    ;;

  RunAllTestsInOrg)

    echo "Running all Apex tests in the org..."

    sf apex run test \
      --target-org "$TARGET_ORG" \
      --test-level RunAllTestsInOrg \
      --wait "$WAIT_TIME" \
      --result-format human

    ;;

  RunSpecifiedTests)

    if [ -z "$TEST_CLASSES" ]; then
        echo "ERROR: TEST_CLASSES is not set."
        echo "Example:"
        echo "TEST_CLASSES='AccountTriggerTest ContactTriggerTest' ./scripts/07-run-tests.sh"
        exit 1
    fi

    echo "Running specified Apex tests:"
    echo "$TEST_CLASSES"

    sf apex run test \
      --target-org "$TARGET_ORG" \
      --tests $TEST_CLASSES \
      --wait "$WAIT_TIME" \
      --result-format human

    ;;

  *)
    echo "ERROR: Unsupported TEST_LEVEL: $TEST_LEVEL"
    echo "Supported values:"
    echo "  RunLocalTests"
    echo "  RunAllTestsInOrg"
    echo "  RunSpecifiedTests"
    exit 1
    ;;

esac

echo ""
echo "======================================"
echo " Apex Tests Completed Successfully"
echo "======================================"