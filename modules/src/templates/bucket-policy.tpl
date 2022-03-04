{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Allow listing and general read behavior",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "${IAM_ROLE_ARN}"
                ]
            },
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "${BUCKET_ARN}"
        },
        {
            "Sid": "Allow object creation, mutation, and deletion",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "${IAM_ROLE_ARN}"
                ]
            },
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectVersionTagging",
                "s3:GetObjectVersion"
            ],
            "Resource": "${BUCKET_ARN}"
        }]
        }