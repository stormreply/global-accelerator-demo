resource "aws_s3_bucket" "assets" {
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  # checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  # checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled"
  # checkov:skip=CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
  # checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block"
  # checkov:skip=CKV2_AWS_61: "Ensure that an S3 bucket has a lifecycle configuration"
  # checkov:skip=CKV2_AWS_62: "Ensure S3 buckets should have event notifications enabled"
  bucket = local._deployment
}

resource "aws_s3_bucket_public_access_block" "assets" {
  bucket                  = aws_s3_bucket.assets.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

locals {
  _asset_files = {
    "architecture.drawio.svg"   = "${path.module}/assets/architecture.drawio.svg"
    "architecture.inverted.svg" = "${path.module}/assets/architecture.inverted.svg"
    "architecture.black.svg"    = "${path.module}/assets/architecture.black.svg"
    "demo.html"                 = "${path.module}/assets/demo.html"
  }
}

resource "aws_s3_object" "assets" {
  for_each     = local._asset_files
  bucket       = aws_s3_bucket.assets.id
  key          = each.key
  source       = each.value
  etag         = filemd5(each.value)
  content_type = endswith(each.key, ".svg") ? "image/svg+xml" : "text/html"
}
