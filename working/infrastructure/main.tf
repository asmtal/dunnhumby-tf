module "infrastructure" {
  source                      = "../../modules/src"
  aws_region                  = var.aws_region
  aws_shared_credentials_file = var.aws_shared_credentials_file
  environment                 = var.environment
  name                        = var.name
  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  generic_tags                = var.generic_tags
  iam_role_arn                = var.iam_role_arn
  bucket_arn                  = var.bucket_arn
}