variable "gandi_api_key" {
}

variable "home_ip" {
}

provider "gandi" {
  key = var.gandi_api_key
}
