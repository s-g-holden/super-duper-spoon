variable "name" {
  description = "A unique name for your Lambda Function"
  type        = string
  default     = "quando"
}

variable "description" {
  description = "Description of your Lambda Function (or Layer)"
  type        = string
  default     = "A lambda function that tells the time."
}

variable "handler" {
  description = "Lambda Function entrypoint in your code"
  type        = string
  default     = "main.handler"
}

variable "runtime" {
  description = "Lambda Function runtime"
  type        = string
  default     = "python3.8"
}

variable "source_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = any # string | list(string | map(any))
  default     = "../../../../../src/quando"
}

variable "country_code" {
  description = "The country code the lambda will report time for."
  type        = string
  default     = "GB"
}