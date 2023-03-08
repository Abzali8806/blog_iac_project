locals {
  compute_tags = {
    tf_source = "compute_module_resources"
    Project   = "Blog_iac_project"
    Owner     = "Abdullah Ali"
  }

  webserver_tags = {
    Name = "django_web_instance"
    tf_source = "compute_module_resources"
    Project   = "Blog_iac_project"
    Owner     = "Abdullah Ali"
  }
}

# key pair start

data "aws_key_pair" "tempkp" {
  key_name           = "tempkp"
  # include_public_key = true

  # filter {
  #   name   = "tag:Component"
  #   values = ["web"]
  # }
}


output "fingerprint" {
  value = data.aws_key_pair.tempkp.fingerprint
}

output "name" {
  value = data.aws_key_pair.tempkp.key_name
}

output "id" {
  value = data.aws_key_pair.tempkp.id
}

output "ssh_key" {
  value = var.ssh_key
}

# key pair end


# Security Groups - hhtp and ssh
resource "aws_security_group" "tf_allow_tcp" {
  name        = "tf_allow_tcp"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.web_blog_vpc.id

  ingress {
    description = "http from web taffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allows ssh connectivity"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.compute_tags
}


# resource "aws_network_interface" "webserver_ni1" {
#   subnet_id       = aws_subnet.public_subnet1.id
#   security_groups = [aws_security_group.tf_allow_tcp.id]
# }

# resource "aws_network_interface" "webserver_ni2" {
#   subnet_id       = aws_subnet.public_subnet2.id
#   security_groups = [aws_security_group.tf_allow_tcp.id]
# }

# EC2 Instances
resource "aws_instance" "django-web1" {
  # count         = 2
  ami           = var.ami
  key_name      = "tempkp"
  instance_type = var.instance_size
  subnet_id       = aws_subnet.public_subnet1.id
  security_groups = [aws_security_group.tf_allow_tcp.id]
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update
  sudo echo ${var.ssh_key} > /home/ubuntu/.ssh/authorized_keys
  EOF

   tags = {
    Name = "Djano server 1"   
  }
}

resource "aws_instance" "django-web2" {
  # count         = 2
  ami           = var.ami
  key_name      = "tempkp"
  instance_type = var.instance_size
  subnet_id       = aws_subnet.public_subnet2.id
  security_groups = [aws_security_group.tf_allow_tcp.id]
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update
  sudo echo ${var.ssh_key} > /home/ubuntu/.ssh/authorized_keys
  EOF

  # network_interface {
  #   network_interface_id = aws_network_interface.webserver_ni2.id
  #   device_index=1
  # }

   tags = {
    Name = "Djano server 2"   
  }
}