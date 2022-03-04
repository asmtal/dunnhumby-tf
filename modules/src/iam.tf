resource "aws_iam_instance_profile" "dunnhumby_profile" {
  name = "dunnhumby_profile"
  role = aws_iam_role.dunnhumby_role.name
}

resource "aws_iam_role" "dunnhumby_role" {
  name               = "dunnhumby_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
EOF
}

resource "aws_iam_policy" "dunnhumby_s3_policy" {
  name   = "dunnhumby_s3_policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_s3fullacess" {
  role       = aws_iam_role.dunnhumby_role.name
  policy_arn = aws_iam_policy.dunnhumby_s3_policy.arn
}

output "aws_iam_role_arn" {
  value = aws_iam_role.dunnhumby_role.arn

  depends_on = [
    aws_iam_role.dunnhumby_role
  ]
}