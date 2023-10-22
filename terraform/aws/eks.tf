module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  cluster_name = "my-eks-cluster"
  cluster_version = "1.28"
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

resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = "my-namespace"
  }
}


