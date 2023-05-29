// Development
resource "aws_s3_bucket" "talelio_test_content" {
  bucket = "talelio-test-content"
}

// Production
resource "aws_s3_bucket" "talelio_user_content" {
  bucket = "talelio-user-content"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "talelio_test_content_public" {
  bucket = aws_s3_bucket.talelio_test_content.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "talelio_user_content_public" {
  bucket = aws_s3_bucket.talelio_user_content.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "talelio_test_content_policy" {
  bucket = aws_s3_bucket.talelio_test_content.id
  policy = data.aws_iam_policy_document.talelio_test_content_public_read_only.json
}

resource "aws_s3_bucket_policy" "talelio_user_content_policy" {
  bucket = aws_s3_bucket.talelio_user_content.id
  policy = data.aws_iam_policy_document.talelio_user_content_public_read_only.json
}
