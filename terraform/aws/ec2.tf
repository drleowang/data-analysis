# resource "aws_instance" "my_instance" {
#   ami           = "ami-0fc5d935ebf8bc3bc"  # Ubuntu 22
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.my_subnet.id
#   security_groups = [aws_security_group.my_ec2_security_group.name]
# }

# resource "aws_security_group" "my_ec2_security_group" {
#   name_prefix = "my-ec2-security-group"
  
#   # 定义安全组规则，允许 SSH 访问
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # 限制来源 IP 地址以提高安全性
#   }
# }

