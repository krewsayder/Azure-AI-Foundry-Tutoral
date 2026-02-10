terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Will use ARM_SUBSCRIPTION_ID from environment
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Cognitive Services Account (Azure OpenAI)
resource "azurerm_cognitive_account" "openai" {
  name                = "cog-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "OpenAI"
  sku_name            = "S0"
  
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Embedding Model Deployment
resource "azurerm_cognitive_deployment" "embedding" {
  name                 = var.embedding_deployment_name
  cognitive_account_id = azurerm_cognitive_account.openai.id
  
  model {
    format  = "OpenAI"
    name    = var.embedding_model_name
    version = var.embedding_model_version
  }
  
  scale {
    type     = "Standard"
    capacity = var.embedding_capacity
  }
}

# Write API credentials to .env file
resource "local_file" "env_file" {
  content = <<-EOT
    AZURE_OPENAI_ENDPOINT=${azurerm_cognitive_account.openai.endpoint}
    AZURE_OPENAI_API_KEY=${azurerm_cognitive_account.openai.primary_access_key}
    AZURE_OPENAI_EMBEDDING_DEPLOYMENT=${azurerm_cognitive_deployment.embedding.name}
    AZURE_OPENAI_API_VERSION=2024-02-01
  EOT
  
  filename        = "${path.module}/../.env"
  file_permission = "0600"
}
