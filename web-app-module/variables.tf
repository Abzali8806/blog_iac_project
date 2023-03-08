variable "az_one" {
  type        = string
  default     = "eu-west-2b"
  description = "London AZ one"
}
variable "az_two" {
  type        = string
  default     = "eu-west-2c"
  description = "London AZ two"
}
variable "ami" {
  type        = string
  default     = "ami-0aaa5410833273cfe"
  description = "EC2 instance ubuntu machine image"
}
variable "instance_size" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance size : t3 family"
}

variable "ssh_key" {
  type = string
  description = "public ssh key used by ansible"
}