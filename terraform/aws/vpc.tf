# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # You can adjust the CIDR block as needed
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Create a route table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-route-table"
  }
}

# Create a route to the internet via the internet gateway
resource "aws_route" "my_route" {
  route_table_id = aws_route_table.my_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}

# Create a subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24" # Adjust the CIDR block for your subnet
  availability_zone = "us-east-1a" # Change the availability zone as needed
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "my_subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_subnet" "my_subnets" {
  count = 2
  cidr_block = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-subnet-${count.index}"
  }
}

resource "aws_route_table_association" "my_subnets_association" {
  count          = 2 
  subnet_id      = aws_subnet.my_subnets[count.index].id
  route_table_id = aws_route_table.my_route_table.id
}