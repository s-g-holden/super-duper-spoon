package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the Terraform module in examples/terraform-aws-lambda-example using Terratest.
func TestBasicExample(t *testing.T) {
	t.Parallel()

	// Give this lambda function a unique ID for a name so we can distinguish it from any other lambdas
	// in your AWS account
	countryCode := fmt.Sprintf("US")

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/basic",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"region": awsRegion,
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	functionName := terraform.Output(t, terraformOptions, "lambda_function_name")

	// Invoke the function, so we can test its output
	response := aws.InvokeFunction(t, awsRegion, functionName, ExampleFunctionPayload{ShouldFail: false, Echo: "hi!"})

	// This function just echos it's input as a JSON string when `ShouldFail` is `false``
	assert.Contains(t, string(response), string(countryCode))
}

type ExampleFunctionPayload struct {
	Echo       string
	ShouldFail bool
}
