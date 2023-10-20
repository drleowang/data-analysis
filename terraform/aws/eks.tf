module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name = "my-eks-cluster"
  cluster_version = "1.21"
  subnet_ids = aws_subnet.my_subnets[*].id
  

  vpc_id = aws_vpc.my_vpc.id


  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}


