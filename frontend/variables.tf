// frontend/variables.tf

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  default     = "dev"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
}

variable "frontend_replicas" {
  description = "number of frontend replicas"
  default = 1
}