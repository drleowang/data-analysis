module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
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
  cluster_name = module.eks_cluster.cluster_name
  cluster_id = module.eks_cluster.cluster_id
  subnets = module.eks_cluster.subnets
  vpc_id = module.eks_cluster.vpc_id
  instance_type = "t2.medium"  # Adjust the instance type as needed
  desired_capacity = 2  # Adjust the desired number of nodes
}

# Outputs for the node group
output "node_group_name" {
  value = module.my_node_group.node_group_name
}

output "node_group_id" {
  value = module.my_node_group.node_group_id
}


