variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key"
  type        = string
  sensitive    = true
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret key"
  type        = string
  sensitive    = true
  default = ""
}
