#!/bin/bash
RESOURCE_GROUP="rg-atomicpulse-sprint1"

echo "=== Excluindo o Grupo de Recursos da Azure ==="
az group delete --name $RESOURCE_GROUP --yes --no-wait
echo "=== Solicitação de exclusão enviada! ==="