output "vpc_id" {
  # create variable in external modules to use this elsewhere
  description = "outputs vpcID"
  value       = aws_vpc.web_blog_vpc.id
}

#  ssh key pair outputs
#  You need to figure out which one is being used
output "name" {
  value = data.aws_key_pair.tempkp.key_name
}

output "id" {
  value = data.aws_key_pair.tempkp.id
}

output "ssh_key" {
  value = var.ssh_key
}