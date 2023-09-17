terraform {
  #The version of terraform we are using. Think "node version"
  required_version = ">= 0.13.1"

  required_providers {
    #There is providers for almost every cloud provider
    #We are using AWS. You can find the list of providers here: https://registry.terraform.io/browse/providers
    #Think of this as the package.json
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}


