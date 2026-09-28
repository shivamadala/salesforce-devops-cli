#!/bin/bash

set -e

echo "======================================"
echo " Generate Salesforce package.xml"
echo "======================================"

OUTPUT_FILE="${OUTPUT_FILE:-manifest/generated-package.xml}"
API_VERSION="${API_VERSION:-65.0}"

mkdir -p "$(dirname "$OUTPUT_FILE")"

echo "Output File : $OUTPUT_FILE"
echo "API Version : $API_VERSION"

cat > "$OUTPUT_FILE" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Package xmlns="http://soap.sforce.com/2006/04/metadata">

    <types>
        <members>*</members>
        <name>ApexClass</name>
    </types>

    <types>
        <members>*</members>
        <name>ApexTrigger</name>
    </types>

    <types>
        <members>*</members>
        <name>CustomObject</name>
    </types>

    <types>
        <members>*</members>
        <name>Flow</name>
    </types>

    <types>
        <members>*</members>
        <name>PermissionSet</name>
    </types>

    <version>$API_VERSION</version>

</Package>
EOF

echo ""
echo "package.xml generated successfully."

echo ""
echo "======================================"
echo " Generated Manifest"
echo "======================================"

cat "$OUTPUT_FILE"