# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder (.terragrunt-cache), and execute your Terraform commands in that folder. If any environment
# needs to deploy a different module version, it should redefine this block with a different ref to override the
# deployed version.
terraform {
  source = local.base_source_url
}


# Locals are named constants that are reusable within the configuration.
locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  environment_name = local.environment_vars.locals.environment

  # Set base url for override purposes
  base_source_url = "git::git@github.com:s-g-holden/super-duper-spoon.git//infrastructure/modules/quando"
}


# These are input parameters to the terraform module, consider TF_VAR_
inputs = {
  name = "${local.environment_name}-quando"
}