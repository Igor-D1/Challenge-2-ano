#!/bin/bash

# Define variáveis
RESOURCE_GROUP="rg-atomicpulse-sprint1"
LOCATION="southafricanorth"
VM_NAME="vm-atomicpulse-api"
ADMIN_USER="azureuser"

echo "=== 1. Criando Grupo de Recursos na Azure ==="
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "=== 2. Criando a Azure Virtual Machine (Ubuntu) ==="
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image Ubuntu2204 \
  --admin-username $ADMIN_USER \
  --generate-ssh-keys \
  --public-ip-sku Standard

echo "=== 3. Liberando a porta 8080 no NSG ==="
az vm open-port --port 8080 --resource-group $RESOURCE_GROUP --name $VM_NAME

echo "=== 4. Endereço IP Público da VM ==="
az vm list-ip-addresses --resource-group $RESOURCE_GROUP --name $VM_NAME --output table

echo "=== Provisionamento concluído com sucesso! ==="