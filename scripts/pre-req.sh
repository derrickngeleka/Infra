#!/bin/bash
RESOURCE_GROUP_NAME="dmnlaabs-tf-state-rg"
STORAGE_ACCOUNT_NAME_DEV="dmnlaabdevstfstate"
STORAGE_ACCOUNT_NAME_STAGE="dmnlaabstagestfstate"
CONTAINER_NAME="tfstate"

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location centralus
# Create storage accounts
# Development
az storage account create --name $STORAGE_ACCOUNT_NAME_DEV --resource-group $RESOURCE_GROUP_NAME --location centralus --sku Standard_LRS
# Staging
az storage account create --name $STORAGE_ACCOUNT_NAME_STAGE --resource-group $RESOURCE_GROUP_NAME --location centralus --sku Standard_LRS
# Create blob containers
# Development
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME_DEV
# Staging
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME_STAGE
