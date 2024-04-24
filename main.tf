provider "aws" {
  region = var.aws_region
  # Add other required configuration options here, such as access_key and secret_key if needed
}

# Load network module
module "network" {
  source                     = "./modules/network"
  region = var.aws_region
  vpc_tag_name               = var.vpc_tag_name
  eks_cluster_name           = var.eks_cluster_name
}

# Load EKS module
module "eks" {
  source = "./modules/eks"

  eks_cluster_name       = var.eks_cluster_name
  vpc_id                 = module.network.vpc_id
  cluster_sg_name        = var.cluster_sg_name
  private_subnet_ids     = module.network.private_subnet_ids
  nodes_sg_name          = var.nodes_sg_name
  public_subnet_ids      = module.network.public_subnet_ids
  node_group_name        = var.node_group_name
  eks_cluster_subnet_ids = concat(module.network.private_subnet_ids, module.network.public_subnet_ids)
}