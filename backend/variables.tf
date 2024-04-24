// backend/variables.tf

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  default     = "dev"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
}

variable "backend_replicas" {
  description = "number of backend replicas"
  default = 1
}