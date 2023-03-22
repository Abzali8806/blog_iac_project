variable "region" {
  description = "region where infrastructure will be hosted"
  type        = string
  default     = "eu-west-2"
}

variable "pub_ssh_key" {
  type        = string
  description = "copy of ssh key into EC2 instance"
  default     = "no default"
}