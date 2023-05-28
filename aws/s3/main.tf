resource "aws_s3_bucket" "talelio_test_content" {
  bucket = "talelio-test-content"
}

resource "aws_s3_bucket_public_access_block" "talelio_test_content_public" {
  bucket = aws_s3_bucket.talelio_test_content.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "talelio_test_content_policy" {
  bucket = aws_s3_bucket.talelio_test_content.id
  policy = data.aws_iam_policy_document.public_read_only.json
}
