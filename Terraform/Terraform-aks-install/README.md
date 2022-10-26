 Connect to AKS using Azure CLI:

`az aks get-credentials --resource-group name_of_rg  --name aks_name`

 Connect to ACR using Azure CLI:

 `az acr login --name_of_acr`

 Integrate the AKS cluster with the ACR using Azure CLI:

 `az aks update -n aks_name -g resource_group_name --attach-acr acr_name`