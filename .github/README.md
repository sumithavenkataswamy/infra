markdown
# 🚀 Infrastructure Deployment with Bicep

This repository contains Bicep templates to deploy Azure infrastructure resources including:

- Resource Groups  
- App Service Plan & App Service  
- Service Bus Namespace & Queues  
- Key Vault  
- App Configuration
- Storage Account

---

## 📂 **Contents**

- [Prerequisites](#✅-prerequisites)  
- [Clone Repository](#🔁-clone-repository)  
- [Local Deployment Steps](#💻-local-deployment-steps)  
- [Create Azure Service Principal](#🔐-create-azure-service-principal)  
- [Configure GitHub Secrets](#🔧-configure-github-secrets)  
- [Deploy via GitHub Actions Pipeline](#⚙️-deploy-via-github-actions-pipeline)  

---

## ✅ Prerequisites

Ensure the following are installed on your local machine:

- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)  
- [Bicep CLI](https://learn.microsoft.com/azure/azure-resource-manager/bicep/install) (`az bicep install`)  
- Git  

---

## 🔁 Clone Repository

```bash
git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>
💻 Local Deployment Steps
Login to Azure
bash
az login
Check your subscription
bash
az account show
If needed, switch subscription
bash
az account set --subscription "<Your Subscription Name or ID>"
Validate Bicep template
bash
az deployment sub validate \
  --location westeurope \
  --template-file infra/main.bicep \
  --parameters environmentName=dev
Preview resources (optional but recommended)
bash
az deployment sub what-if \
  --location westeurope \
  --template-file infra/main.bicep \
  --parameters environmentName=dev
Deploy
bash
az deployment sub create \
  --location westeurope \
  --template-file infra/main.bicep \
  --parameters environmentName=dev
🔐 Create Azure Service Principal
To use GitHub Actions for deployment, create a Service Principal:

bash
az ad sp create-for-rbac --name "<your-sp-name>" --role Contributor --scopes /subscriptions/<your-subscription-id> --sdk-auth
✅ This command outputs a JSON block. It looks like:

json
{
  "clientId": "...",
  "clientSecret": "...",
  "subscriptionId": "...",
  "tenantId": "...",
  "activeDirectoryEndpointUrl": "...",
  "resourceManagerEndpointUrl": "...",
  "activeDirectoryGraphResourceId": "...",
  "sqlManagementEndpointUrl": "...",
  "galleryEndpointUrl": "...",
  "managementEndpointUrl": "..."
}
🔧 Configure GitHub Secrets
Go to your repository → Settings → Secrets and variables → Actions → New repository secret

Add secrets for each environment:

Secret Name	Value
AZURE_CREDENTIALS_DEV	(Paste JSON output for dev subscription)
AZURE_CREDENTIALS_TEST	(Paste JSON output for test subscription)
AZURE_CREDENTIALS_SIT	(Paste JSON output for sit subscription)
AZURE_CREDENTIALS_PROD	(Paste JSON output for prod subscription)
(Optional) Add location as secret if needed:

Secret Name	Value
AZURE_LOCATION	westeurope
⚙️ Deploy via GitHub Actions Pipeline
This repository includes .github/workflows/infra-deploy.yml workflow. It:

Runs on pushes to main or develop

Can be triggered manually with environment selection

Trigger manually
Go to Actions tab

Select Build and Deploy Infrastructure workflow

Click Run workflow

Select environment (dev, test, sit, prod)

Click Run workflow

🚀 Outcome
This will:

✔️ Create the resource group

✔️ Deploy all Bicep modules (App Service, Key Vault, Service Bus, etc.)

✔️ Validate your infrastructure pipeline end-to-end

📞 Support
For issues or enhancements, raise an Issue in this repository.

Happy Infrastructure as Code! 🎉

✅ Final Steps for You
Replace <your-org> and <your-repo> with your GitHub organization and repository names

Replace <your-subscription-id> and <your-sp-name> accordingly


Let me know if you'd like a matching `wiki.md` template to document module inte
