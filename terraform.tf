terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 6.4.0"
      }
    }
    required_version = ">= 1.4.0"

    backend "s3" {
        bucket = "gkinfrahub-terraform-bucket"
        region = "ap-south-1"
        dynamodb_table = "gkinfrahub-terraform-bucket-lock"
  }
}
