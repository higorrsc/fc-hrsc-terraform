terraform {
  required_version = ">= 1.12.2"
  required_providers {
    aws   = ">=6.6.0"
    local = ">=2.5.3"
  }
}

provider "aws" {
  region = "us-east-1"
}
