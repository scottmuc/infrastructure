

provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "smuc-terraform-state-files"
    key = "dns.terraform.tfstate"
    region = "eu-central-1"
  }
}