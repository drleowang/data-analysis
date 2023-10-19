terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "ORC"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
        name = "data-analysis"
    }
  }
  # required_providers {
  #   aws = {
  #     source  = "hashicorp/aws"
  #     version = "~> 3.28.0"
  #   }
  # }

  # required_version = ">= 0.14.0"
}

# Specify the provider and region
provider "aws" {
  region = "us-east-1" # Change to your desired region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}
