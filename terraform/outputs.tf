output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "openai_endpoint" {
  description = "Azure OpenAI endpoint URL"
  value       = azurerm_cognitive_account.openai.endpoint
}

output "openai_api_key" {
  description = "Azure OpenAI API key"
  value       = azurerm_cognitive_account.openai.primary_access_key
  sensitive   = true
}

output "embedding_deployment_name" {
  description = "Name of the embedding model deployment"
  value       = azurerm_cognitive_deployment.embedding.name
}

output "env_file_location" {
  description = "Location of the generated .env file"
  value       = abspath("${path.module}/../.env")
}
