terraform {
  # backend "s3" {
  #   bucket         = "terraform-state-iac250223"
  #   key            = "tf-infra/terraform.tfstate"
  #   region         = "eu-west-2"
  #   dynamodb_table = "terraform-state-lock"
  #   encrypt        = true
  # }

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


resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-iac250223"
  force_destroy = true
  versioning {
    enabled = true
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


module "web_app_1" {
  source = "./web-app-module"

  az_one        = "eu-west-2a"
  az_two        = "eu-west-2c"
  ami           = "ami-0aaa5410833273cfe"
  instance_size = "t3.micro"
  ssh_key       = var.pub_ssh_key

}