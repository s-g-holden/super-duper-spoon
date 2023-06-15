module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.name
  description   = var.description
  handler       = var.handler
  runtime       = var.runtime

  source_path = "${path.module}/src"

  environment_variables = {
    COUNTRY_CODE = var.country_code
  }

  tags = {
    Name = "my-lambda1"
  }
}