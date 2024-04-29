terraform {
  required_providers {
    gandi = {
      source = "go-gandi/gandi"
      version = "~> 2.3.0"
    }
  }
}

variable "gandi_api_key" {
}

variable "home_ip" {
}

provider "gandi" {
  key = var.gandi_api_key
}
