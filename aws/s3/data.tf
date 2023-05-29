data "aws_iam_policy_document" "talelio_test_content_public_read_only" {
  statement {
    sid    = "AllowPublicRead"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.talelio_test_content.arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "talelio_user_content_public_read_only" {
  statement {
    sid    = "AllowPublicRead"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.talelio_user_content.arn}/*"
    ]
  }
}
