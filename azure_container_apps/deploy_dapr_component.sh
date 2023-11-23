#!/bin/bash

COSMOSDB_NAME=$1
COSMOSDB_RESOURCE_GROUP=$2
CONTAINER_APP_ENVIRONMENT_RESOURCE_GROUP=$3
CONTAINER_APP_ENVIRONMENT_NAME=$4

yaml_file="azure_container_apps/component.yml"
#Fetch the master key for the CosmosDB
masterKey=$(az cosmosdb keys list --name $COSMOSDB_NAME --resource-group $COSMOSDB_RESOURCE_GROUP | jq -r '.primaryMasterKey')
#Replace placeholder in the manifest file for the component
sed -ri "s/^(\s*)(value\s*:\s*masterkeyvalue\s*$)/\1value: $masterKey/" $yaml_file
#Create DAPR component
az containerapp env dapr-component set -g $CONTAINER_APP_ENVIRONMENT_RESOURCE_GROUP --name  $CONTAINER_APP_ENVIRONMENT_NAME --yaml $yaml_file --dapr-component-name cosmosdb
#Revert the change
sed -ri "s/^(\s*)(value\s*:\s*$masterKey\s*$)/\1value: masterkeyvalue/" $yaml_file

