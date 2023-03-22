# Private subnet
resource "aws_subnet" "private_subnet1" {
  vpc_id            = var.custom_vpc_id
  cidr_block        = "10.27.0.129/24  b"
  availability_zone = var.az_one
  map_public_ip_on_launch = true

  tags = local.network_tags
}

# Routing Resources
resource "aws_route_table" "public_rt" {
  vpc_id = var.custom_vpc_id

  route {
    # Add public subnet cidr as the route
  }

  tags = local.network_tags
}

resource "aws_route_table_association" "rta_1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

# resource "aws_route_table_association" "rta_2" {
#   subnet_id      = aws_subnet.public_subnet2.id
#   route_table_id = aws_route_table.public_rt.id
# } 

# Routing end
