module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  cluster_name = "my-eks-cluster"
  cluster_version = "1.28"
  cluster_endpoint_public_access = true
  subnet_ids = aws_subnet.my_subnets[*].id
  

  vpc_id = aws_vpc.my_vpc.id


  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
  # manage_aws_auth_configmap = true
 
  # aws_auth_roles = [
  #   {
  #     rolearn  = "arn:aws:iam::825242866589:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_66ceff32db3f5f14" # replace me
  #     username = "Administrator"
  #     groups   = ["system:masters"]
  #   },
  # ]
 
  # aws_auth_users = [
  #   {
  #     userarn  = "arn:aws:iam::825242866589:user/ottawaadmin" # replace me
  #     username = "ottawaadmin"
  #     groups   = ["system:masters"]
  #   },
  # ]
}

# Define your node group
# module "my_node_group" {
#   source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
#   name = "my_node_group"
# #   node_group_name = "my_node_group_name"

#   cluster_name = module.eks_cluster.cluster_name
#   subnet_ids = aws_subnet.my_subnets[*].id
# #   subnet_ids = module.eks_cluster.subnets

#   instance_types = ["t2.medium"]  # Adjust the instance type as needed
#   desired_size = 2  # Adjust the desired number of nodes
# }

# resource "kubernetes_namespace" "my_namespace" {
#   metadata {
#     name = "my-namespace"
#   }
# }

module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"

  name            = "separate-eks-mng"
  cluster_name = "my-eks-cluster"
  cluster_version = "1.28"

  subnet_ids = aws_subnet.my_subnets[*].id

  // The following variables are necessary if you decide to use the module outside of the parent EKS module context.
  // Without it, the security groups of the nodes are empty and thus won't join the cluster.
  cluster_primary_security_group_id = module.eks_cluster.cluster_primary_security_group_id
  vpc_security_group_ids            = [module.eks_cluster.node_security_group_id]

  // Note: `disk_size`, and `remote_access` can only be set when using the EKS managed node group default launch template
  // This module defaults to providing a custom launch template to allow for custom security groups, tag propagation, etc.
  // use_custom_launch_template = false
  // disk_size = 50
  //
  //  # Remote access cannot be specified with a launch template
  //  remote_access = {
  //    ec2_ssh_key               = module.key_pair.key_pair_name
  //    source_security_group_ids = [aws_security_group.remote_access.id]
  //  }

  min_size     = 1
  max_size     = 10
  desired_size = 1

  instance_types = ["t3.large"]
  capacity_type  = "SPOT"

  labels = {
    Environment = "test"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  taints = {
    dedicated = {
      key    = "dedicated"
      value  = "gpuGroup"
      effect = "NO_SCHEDULE"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}


