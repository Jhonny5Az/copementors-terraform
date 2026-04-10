terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }
  }
  required_version = "~> 1.2"
  /*   backend "local" {
    path = "./terraform.tfstate"
  }
 */
  backend "s3" {
    bucket = "cope-terraform-project-s3-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-west-1"
  }
}