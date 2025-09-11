# -------------------------------
# S3 Bucket for Static Website Hosting
# -------------------------------
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  tags = merge({
    Name = var.bucket_name
  }, var.tags)
}

# -------------------------------
# Object Ownership
# Enforce bucket owner control
# -------------------------------
resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# -------------------------------
# Block all public access
# Only CloudFront (via OAI) will be able to read
# -------------------------------
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# -------------------------------
# Versioning (good practice)
# -------------------------------
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

# -------------------------------
# Upload local files
# -------------------------------
resource "aws_s3_object" "files" {
  for_each = local.files_to_upload

  bucket       = aws_s3_bucket.main.id
  key          = each.key
  source       = "${path.module}/files/${each.key}" # assumes ./files dir inside module
  content_type = each.value.content_type
}

# -------------------------------
# Bucket Policy (allow CloudFront OAI to read objects)
# This is CRUCIAL when public access is blocked
# -------------------------------
resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.main.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.cloudfront_oai_iam_arn   # Comes from CloudFront module output
        }
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.main.arn}/*"
      }
    ]
  })
}

# -------------------------------
# Local variable for file uploads
# -------------------------------
locals {
  files_to_upload = var.upload_files ? {
    "index.html" = { content_type = "text/html" }
  } : {}
}
