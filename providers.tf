terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                  = "eu-north-1"
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "vscode"
}