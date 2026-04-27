#!/bin/bash

# check environment argument
if [ -z "$1" ]; then
  echo "Usage: ./backend.sh <dev|prod>"
  exit 1
fi

ENVIRONMENT=$(echo "$1" | tr '[:upper:]' '[:lower:]')

if [ "$ENVIRONMENT" != "dev" ] && [ "$ENVIRONMENT" != "prod" ]; then
  echo "Invalid environment. Use: dev or prod"
  exit 2
fi

# =============================
# Project Variables
# =============================
PROJECT="n8n"
LOCATION="eastus"
LOCATION_SHORT="eus2"

OWNER="devops-team"
APPLICATION="n8n-platform"

# =============================
# Backend Naming (Dev/Prod separated)
# =============================
RG_NAME="${PROJECT}-tfstate-${ENVIRONMENT}-rg"
STORAGE_ACCOUNT="${PROJECT}tfstate${ENVIRONMENT}sa"
CONTAINER="${PROJECT}-tfstate"
STATE_FILE="${ENVIRONMENT}.tfstate"

echo "=================================="
echo "Project      : $PROJECT"
echo "Environment  : $ENVIRONMENT"
echo "ResourceGroup: $RG_NAME"
echo "StorageAcct  : $STORAGE_ACCOUNT"
echo "=================================="

##### Resource Group #####
if az group show --name "$RG_NAME" >/dev/null 2>&1; then
    echo "✔ Resource group exists"
else
    echo "➜ Creating resource group..."
    az group create \
        --name "$RG_NAME" \
        --location "$LOCATION"
fi

##### Storage Account #####
if az storage account show \
   --name "$STORAGE_ACCOUNT" \
   --resource-group "$RG_NAME" >/dev/null 2>&1; then

   echo "✔ Storage account exists"
else
   echo "➜ Creating storage account..."
   az storage account create \
      --name "$STORAGE_ACCOUNT" \
      --resource-group "$RG_NAME" \
      --location "$LOCATION" \
      --sku Standard_LRS \
      --kind StorageV2 \
      --allow-blob-public-access false
fi

##### Blob Container #####
if az storage container exists \
   --name "$CONTAINER" \
   --account-name "$STORAGE_ACCOUNT" \
   --auth-mode login \
   --query exists -o tsv | grep true >/dev/null; then

   echo "✔ Container exists"
else
   echo "➜ Creating container..."
   az storage container create \
      --name "$CONTAINER" \
      --account-name "$STORAGE_ACCOUNT" \
      --auth-mode login
fi

echo "=================================="
echo "✅ Backend infrastructure ready"
echo "Terraform state file: $STATE_FILE"
echo "=================================="