terraform {
  required_providers {
    gandi = {
      source = "go-gandi/gandi"
      version = "~> 2.3.0"
    }
  }
}

variable "gandi_pat" {
}

variable "home_ip" {
}

provider "gandi" {
  personal_access_token = var.gandi_pat
}
