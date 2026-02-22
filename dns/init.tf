terraform {
  # I'm using opentofu so this version constraint pertains more to
  # that CLI not the terraform CLI
  required_version = ">= 1.11"
  required_providers {
    gandi = {
      source  = "go-gandi/gandi"
      version = "~> 2.3.0"
    }
  }
}

variable "gandi_pat" {
  description = "Personal PAT that expires after 90 days"
  type = string
}

variable "home_ip" {
  description = "IP address use to assign to home.scottmuc.com"
  type = string
}

provider "gandi" {
  personal_access_token = var.gandi_pat
}
