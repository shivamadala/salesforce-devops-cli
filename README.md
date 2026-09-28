# Salesforce DevOps CLI

A hands-on Salesforce DevOps project demonstrating Salesforce CLI,
Git-based source control, metadata deployment, validation, testing,
destructive changes, rollback and CI/CD automation.

## Architecture

Developer
    |
    v
Git / GitHub
    |
    v
CI/CD Pipeline
    |
    v
Salesforce CLI
    |
    v
Salesforce APIs
    |
    v
DEV / UAT / PROD


## Project Structure

salesforce-devops-cli/
|
├── README.md
├── .gitignore
├── sfdx-project.json
|
├── manifest/
|   ├── package.xml
|   ├── destructiveChanges.xml
|   └── generated-package.xml
|
├── scripts/
|   ├── 01-authenticate.sh
|   ├── 02-org-info.sh
|   ├── 03-retrieve.sh
|   ├── 04-retrieve-package.sh
|   ├── 05-validate.sh
|   ├── 06-deploy.sh
|   ├── 07-run-tests.sh
|   ├── 08-quick-deploy.sh
|   ├── 09-destructive-deploy.sh
|   ├── 10-compare-git.sh
|   ├── 11-generate-package.sh
|   ├── 12-rollback.sh
|   └── 13-full-pipeline.sh
|
└── .github/
    └── workflows/
        └── salesforce-deploy.yml


## Prerequisites

Install:

- Git
- Node.js
- Salesforce CLI
- Access to a Salesforce Developer/Sandbox org

Verify:

    git --version
    node --version
    sf --version


## Salesforce Authentication

The project supports JWT-based authentication for CI/CD.

Required environment variables:

    SF_USERNAME
    SF_CLIENT_ID
    SF_JWT_KEY_FILE
    SF_INSTANCE_URL

Example:

    export SF_USERNAME="user@example.com"
    export SF_CLIENT_ID="YOUR_CONNECTED_APP_CLIENT_ID"
    export SF_JWT_KEY_FILE="/path/to/server.key"
    export SF_INSTANCE_URL="https://test.salesforce.com"

Authenticate:

    ./scripts/01-authenticate.sh


## Retrieve Metadata

Retrieve metadata using package.xml:

    ./scripts/03-retrieve.sh


## Retrieve a Specific Package

    ./scripts/04-retrieve-package.sh

You can specify another manifest:

    MANIFEST_FILE=manifest/apex-package.xml \
    ./scripts/04-retrieve-package.sh


## Validate Deployment

Validate metadata without deploying:

    ./scripts/05-validate.sh

Example:

    TARGET_ORG=UAT \
    MANIFEST_FILE=manifest/package.xml \
    ./scripts/05-validate.sh


## Deploy

Deploy metadata:

    ./scripts/06-deploy.sh


## Run Apex Tests

Run local tests:

    ./scripts/07-run-tests.sh

Run all tests:

    TEST_LEVEL=RunAllTestsInOrg \
    ./scripts/07-run-tests.sh


## Quick Deploy

After a successful Salesforce validation:

    VALIDATION_ID="JOB_ID" \
    ./scripts/08-quick-deploy.sh


## Destructive Changes

Destructive metadata changes are defined in:

    manifest/destructiveChanges.xml

Run:

    ./scripts/09-destructive-deploy.sh


## Git Comparison

Compare the current branch against main:

    ./scripts/10-compare-git.sh

Example:

    BASE_BRANCH=main \
    ./scripts/10-compare-git.sh


## Generate package.xml

Generate a deployment manifest:

    ./scripts/11-generate-package.sh


## Rollback

Salesforce metadata rollback is handled by redeploying
a previous known-good version from Git.

Example:

    ./scripts/12-rollback.sh <commit-id>


## Full CI/CD Pipeline

Run:

    ./scripts/13-full-pipeline.sh


## CI/CD

GitHub Actions is included in:

    .github/workflows/salesforce-deploy.yml

The workflow demonstrates:

1. Checkout source
2. Install Salesforce CLI
3. Authenticate
4. Validate metadata
5. Deploy metadata


## Salesforce DevOps Concepts Demonstrated

- Git source control
- Salesforce DX project structure
- Salesforce CLI
- Metadata API deployment
- package.xml
- Metadata retrieval
- Deployment validation
- Apex testing
- Quick Deploy
- Destructive changes
- Git-based rollback
- CI/CD
- GitHub Actions
- Environment variables
- Secret management


## Copado / Flosum Mapping

| Copado / Flosum | CLI / DevOps Equivalent |
|---|---|
| Authenticate | sf org login |
| Retrieve | sf project retrieve start |
| Compare | Git / metadata comparison |
| Deployment package | package.xml |
| Validate | sf project deploy start --dry-run |
| Deploy | sf project deploy start |
| Apex tests | sf apex run test |
| Quick Deploy | sf project deploy quick |
| Delete metadata | destructive changes |
| Rollback | Redeploy previous Git version |
| Pipeline | GitHub Actions / Jenkins / GitLab |

## Disclaimer

This repository is a learning and interview-practice project.
Exact Salesforce CLI commands and deployment options may vary
with Salesforce CLI/API versions and organizational deployment
policies.