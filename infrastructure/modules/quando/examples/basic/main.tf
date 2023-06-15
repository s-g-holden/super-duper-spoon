provider "aws" {
  region = var.region
}

resource "random_string" "random_suffix" {
  length  = 8
  special = false
  upper   = false
}

module "quando" {
  source = "../../"

  name        = "quando-${random_string.random_suffix.result}"
  description = "A lambda function that tells the time."
  handler     = "main.handler"
  runtime     = "python3.8"

  country_code = "US"
}