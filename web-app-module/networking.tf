locals {
  network_tags = {
    Name    = "compute_module_resources"
    Project = "Blog_iac_project"
    Owner   = "Abdullah Ali"
  }
}

resource "aws_vpc" "web_blog_vpc" {
  cidr_block = "10.27.0.0/22"

  tags = local.network_tags
}

resource "aws_internet_gateway" "pub_tf_igw" {
  vpc_id = aws_vpc.web_blog_vpc.id

  tags = local.network_tags
}


# Routing Resources
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.web_blog_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pub_tf_igw.id
  }

  tags = local.network_tags
}

resource "aws_route_table_association" "rta_1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "rta_2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
} # Routing end


resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.web_blog_vpc.id
  cidr_block        = "10.27.0.0/25"
  availability_zone = var.az_one
  map_public_ip_on_launch = true

  tags = local.network_tags
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.web_blog_vpc.id
  cidr_block        = "10.27.0.128/25"
  availability_zone = var.az_two
  map_public_ip_on_launch = true

  tags = local.network_tags
}





# Network ACLs

# resource "aws_network_acl" "biac-nacl" {
#   vpc_id     = aws_vpc.web_blog_vpc.id
#   subnet_ids = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

#   egress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 22
#     to_port    = 22
#   }

#   tags = {
#     Name      = "compute_mod_ec2_sg"
#     tf_source = "compute_module_resources"
#     Project   = "Blog_iac_project"
#     Owner     = "Abdullah Ali"
#   }
# }