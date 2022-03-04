variable "aws_region" {
  description = "Name of the default region"
  default     = "us-west-2"
}

# Path to .aws
variable "aws_shared_credentials_file" {
  description = "Credentials file to use"
  default     = ""
}

variable "environment" {
  description = "Working environment"
  default     = "dev"
}

variable "name" {
  description = "company or project name"
  default     = "dunnhumby"
}

variable "ami_id" {
  description = "ami name"
  default     = "ami-070a90e0a26a6c7bd"
}

variable "instance_type" {
  description = "instance type"
  default     = "m5a.xlarge"
}

variable "generic_tags" {
  description = "Map of tags which should be applied to all AWS resources."
  default     = {}
}

variable "iam_role_arn" {
  description = "iam role arn which will be assumed by ec2"
  default     = ""
}

variable "bucket_arn" {
  description = "bucket arn"
  default     = ""
}