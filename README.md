# Azure AI Embeddings Project

This project deploys Azure OpenAI resources with text-embedding-ada-002 model using Terraform, and includes a Python script for interacting with the embeddings API.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0 installed
- Python 3.8+ (for the Python script later)
- An Azure subscription

## Setup Instructions

### 1. Azure Authentication

First, authenticate with Azure and set your subscription ID:

```bash
# Login to Azure
az login

# Set your subscription (replace with your actual subscription ID)
export ARM_SUBSCRIPTION_ID="your-subscription-id-here"

# Verify it's set
echo $ARM_SUBSCRIPTION_ID
```

### 2. Configure Terraform (Optional)

The default configuration uses:
- Project name: `ai-embeddings`
- Environment: `dev`
- Location: `eastus`
- Embedding model: `text-embedding-ada-002`

To customize, create a `terraform.tfvars` file:

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your preferred values
```

### 3. Deploy Infrastructure

```bash
cd terraform

# Initialize Terraform
terraform init

# Preview the changes
terraform plan

# Apply the configuration
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### 4. Verify Deployment

After deployment completes:

1. Check that `.env` file was created in the project root:
   ```bash
   cd ..
   cat .env
   ```

2. View outputs:
   ```bash
   cd terraform
   terraform output
   ```

3. View the API key (sensitive):
   ```bash
   terraform output -raw openai_api_key
   ```

## What Gets Created

- **Resource Group**: `rg-ai-embeddings-dev` (in eastus)
- **Azure OpenAI Service**: `cog-ai-embeddings-dev`
- **Embedding Model Deployment**: `text-embedding-ada-002`
- **Local .env file**: Contains API credentials for Python script

## Environment Variables

After deployment, your `.env` file will contain:

```
AZURE_OPENAI_ENDPOINT=https://cog-ai-embeddings-dev.openai.azure.com/
AZURE_OPENAI_API_KEY=<your-api-key>
AZURE_OPENAI_EMBEDDING_DEPLOYMENT=text-embedding-ada-002
AZURE_OPENAI_API_VERSION=2024-02-01
```

## Next Steps

- Python script and SQLite database setup (coming next)

## Cleanup

To destroy all resources:

```bash
cd terraform
terraform destroy
```

Type `yes` when prompted.

## Troubleshooting

### "Authorization failed" errors
- Ensure you're logged in: `az login`
- Verify subscription is set: `echo $ARM_SUBSCRIPTION_ID`
- Check you have Contributor access to the subscription

### "Quota exceeded" errors
- Azure OpenAI has regional quotas
- Try a different region by changing `location` variable
- Request quota increase in Azure portal

### ".env file not created"
- Check Terraform output: `terraform output env_file_location`
- Manually create .env from terraform outputs if needed

## Security Notes

- The `.env` file is gitignored and should NEVER be committed
- API keys are sensitive - keep them secure
- Consider using Azure Key Vault for production deployments
