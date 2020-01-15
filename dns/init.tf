variable "gandi_api_key" {
}

provider "gandi" {
  key = var.gandi_api_key
}
