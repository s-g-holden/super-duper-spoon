# Quando

This application will tell you the time depending on the country code it has
been configured with.

## Structure

The quando module is organized as follows:

```
.
└── quando/         <module directory specifying quando resources>
    ├── examples/   <terraform usage examples>
    ├── src/        <lambda source code>
    ├── test/       <terratest directory>
    ├── quando/     <configuration directory for quando>
    └── *.tf        <terraform configuration files>
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.63 |
| <a name="requirement_external"></a> [external](#requirement\_external) | >= 1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.63 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_country_code"></a> [country\_code](#input\_country\_code) | The country code the lambda will report time for. | `string` | `"GB"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of your Lambda Function (or Layer) | `string` | `"A lambda function that tells the time."` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Lambda Function entrypoint in your code | `string` | `"main.handler"` | no |
| <a name="input_name"></a> [name](#input\_name) | A unique name for your Lambda Function | `string` | `"quando"` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda Function runtime | `string` | `"python3.8"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda Function |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda Function |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda Function |
<!-- END_TF_DOCS -->


## References

* https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest
* https://github.com/gruntwork-io/terragrunt-infrastructure-modules-example
* https://terratest.gruntwork.io/docs/