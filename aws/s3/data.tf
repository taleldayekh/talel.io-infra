data "aws_iam_policy_document" "public_read_only" {
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
      "${aws_s3_bucket.talelio_test_content.arn}/*"
    ]
  }
}
