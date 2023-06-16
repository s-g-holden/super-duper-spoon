# Configure terraform and terrqagrunt binaries using, tfswitch & tgswitch
terragrunt_version_constraint = "= 0.46.3"
terraform_version_constraint = "= 1.5.0"

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract the variables we need for easy access
  environment_name = local.environment_vars.locals.environment
  aws_region   = local.region_vars.locals.aws_region
}

inputs = {
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "super-duper-${local.environment_name}-${local.aws_region}-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "terraform_locks"
  }
}
