# Configure terraform and terrqagrunt binaries using, tfswitch & tgswitch
terragrunt_version_constraint = "= 0.46.3"
terraform_version_constraint = "= 1.5.0"

terraform {
  source = "git::git@github.com:s-g-holden/super-duper-spoon.git//infrastructure/modules/quando"
}

locals {
  environment_name = "dev"
  aws_region   = "eu-west-2"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "super-duper-${local.environment_name}-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "terraform_locks"
  }
}

inputs = {
  name = "${local.environment_name}-quando"
  country_code = "UK"
}
