variable "gandi_api_key" {
}

provider "aws" {
  region = "eu-central-1"
}

provider "gandi" {
  key = var.gandi_api_key
}

terraform {
  backend "s3" {
    bucket = "smuc-terraform-state-files"
    key = "dns.terraform.tfstate"
    region = "eu-central-1"
  }
}
