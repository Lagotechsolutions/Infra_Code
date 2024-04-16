terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

backend "s3" {
    # Replace this with your bucket name!
    bucket         = "lagotech-state-file"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
} 

# Configure the AWS Provider
provider "aws" {
  shared_credentials_files = ["/Users/yemiade/.aws/credentials"]
  region         = "us-west-2"
}
