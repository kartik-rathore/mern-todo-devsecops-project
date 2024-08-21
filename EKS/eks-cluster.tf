module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  cluster_name                   = local.cluster_name
  cluster_version                = var.kubernetes_version
  cluster_endpoint_public_access = true
  subnet_ids                     = module.vpc.private_subnets

  enable_irsa = true

  tags = {
    cluster = "demo"
  }

  vpc_id = module.vpc.vpc_id


  eks_managed_node_groups = {

    node_group = {
      min_size      = 1
      max_size      = 3
      desired_size  = 2
      instance_type = ["t3.medium"]
    }
  }
}

