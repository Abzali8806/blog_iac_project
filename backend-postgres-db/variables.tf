variable custom_vpc_id {
  type        = string
  default     = ""
  description = "description"
}
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