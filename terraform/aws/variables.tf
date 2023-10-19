variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key"
  type        = string
  sensitive    = true
  default = var.TF_VAR_AWS_ACCESS_KEY_ID
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret key"
  type        = string
  sensitive    = true
  default = var.TF_VAR_AWS_ACCESS_KEY_ID
}
