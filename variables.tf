// variables.tf

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}


variable "vpc_tag_name" {}
variable "eks_cluster_name" {}
variable "cluster_sg_name" {}
variable "nodes_sg_name" {}
variable "node_group_name" {}
