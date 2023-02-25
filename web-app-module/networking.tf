locals {
  tags = {
    Name    = "compute_module_resources"
    Project = "Blog_iac_project"
    Owner   = "Abdullah Ali"
  }
}

resource "aws_vpc" "web_blog_vpc" {
  cidr_block = "10.27.0.0/22"

  tags = local.tags
}

output "name" {
  # create variable in external modules to use this elsewhere
  description = "outputs vpcID"
  value       = aws_vpc.web_blog_vpc.id
}


resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.web_blog_vpc.id
  cidr_block        = "10.27.0.0/25"
  availability_zone = var.az_one

  tags = local.tags
}
resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.web_blog_vpc.id
  cidr_block        = "10.27.0.128/25"
  availability_zone = var.az_two

  tags = local.tags
}