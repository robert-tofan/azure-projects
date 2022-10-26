**"Terraform-full-deployment"** contains the following:

- Azure Kubernetes Cluster:
    - Nginx Ingress Controller (using Helm charts)
    - Cert Manager (using Helm charts)
    - Deployment of an ingress example (using Kubernets)
 - Azure continer registry
 - Mysql Server
 - Mysql DB
 - Firewall Rule for DB
 - Public ip
 - DNS zone
 - DNS A Record

 Connect to AKS using Azure CLI:

`az aks get-credentials --resource-group name_of_rg  --name aks_name`

 Connect to ACR using Azure CLI:

 `az acr login --name_of_acr`

 Integrate the AKS cluster with the ACR using Azure CLI:

 `az aks update -n aks_name -g resource_group_name --attach-acr acr_name`

 Connect to MySQL Server using Azure CLI:

 `mysql -h mysql_server_name.mysql.database.azure.com -u username@mysql_server_name -p`

 To use an existing MySQL database:

 `USE db_name;`