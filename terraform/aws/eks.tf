provider "aws" {
  region = "us-west-2"  # Set your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Adjust the CIDR block to match your VPC
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name = "my-eks-cluster"
  cluster_version = "1.21"
  subnet_ids = aws_subnet.my_subnets

  vpc_id = aws_vpc.my_vpc.id


  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

resource "aws_subnet" "my_subnets" {
  count = 2
  cidr_block = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-subnet-${count.index}"
  }
}
