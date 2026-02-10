variable "project_name" {
  description = "Name of the project, used in resource naming"
  type        = string
  default     = "ai-embeddings"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "embedding_deployment_name" {
  description = "Name for the embedding model deployment"
  type        = string
  default     = "text-embedding-ada-002"
}

variable "embedding_model_name" {
  description = "Model name for embeddings"
  type        = string
  default     = "text-embedding-ada-002"
}

variable "embedding_model_version" {
  description = "Model version for embeddings"
  type        = string
  default     = "2"
}

variable "embedding_capacity" {
  description = "Capacity (throughput) for embedding deployment in thousands of tokens per minute"
  type        = number
  default     = 50
}
