resource "aws_s3_bucket" "dunnhumby_inder" {
  bucket = "dunnhumby_inder"
  tags = {
    name        = "${var.name}-bucket"
    environment = var.environment
  }
  depends_on = [
    aws_iam_role.dunnhumby_role
  ]
}

resource "aws_s3_bucket_policy" "ec2_bucket_access" {
  bucket = "aws_s3_bucket.dunnhumby_inder"
  policy = templatefile("${path.module}/templates/bucket-policy.tpl", { IAM_ROLE_ARN = var.iam_role_arn, BUCKET_ARN = var.bucket_arn })
}

output "aws_s3_bucket_arn" {
  value = aws_s3_bucket.dunnhumby_inder.arn

  depends_on = [
    aws_s3_bucket.dunnhumby_inder
  ]
}