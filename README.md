1. Create an SSH key first, https://docs.microsoft.com/en-us/azure/virtual-machines/linux/mac-create-ssh-keys.

2. Create your Azure credentials, following these directions: https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html.

3. Create a terraform.tfvars file that contains these variables:

```
subscription_id                 = "YOUR AZURE SUBSCRIPTION ID"
service_principal_client_id     = "YOUR SERVICE PRINCIPAL CLIENT ID"
service_principal_client_secret = "YOUR SERVICE PRINCIPAL CLIENT SECRET"
tenant_id                       = "YOUR TENANT ID"
```

4. Create the Azure resources with Terraform:

```
terraform init
teraform plan
terraform apply
```

5. Log in with:

```
ssh -i C:\Users\{YOUR_USERNAME}\.ssh\id_rsa k8suser@k8stestmaster1.eastus.cloudapp.azure.com
```