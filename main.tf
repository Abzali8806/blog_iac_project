terraform {
  backend "s3" {
    bucket         = "terraform-state-iac250223"
    key            = "tf-infra/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "web_app_1" {
  source = "./web-app-module"

  az_one        = "eu-west-2a"
  az_two        = "eu-west-2c"
  ami           = "ami-0aaa5410833273cfe"
  instance_size = "t3.micro"
  ssh_key       = var.pub_ssh_key

}







# module "postgres_db" {
#   source = "../backend-postgres-db"
  
#   vpc_id = module.web_app_1.vpc_id
#   az_one        = "eu-west-2a"
#   az_two        = "eu-west-2c"
# }