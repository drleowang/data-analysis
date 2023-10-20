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
}

# Define your node group
module "my_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  name = "my_node_group"
#   node_group_name = "my_node_group_name"

  cluster_name = module.eks_cluster.cluster_name
#   subnet_ids = module.eks_cluster.subnets

  instance_types = ["t2.medium"]  # Adjust the instance type as needed
  desired_size = 2  # Adjust the desired number of nodes
}


