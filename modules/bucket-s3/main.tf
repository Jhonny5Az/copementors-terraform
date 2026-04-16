
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  count = var.enabled_static_website ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
 
# Ensure Public Access Block settings are in place (these are often defaults, but explicit is better)
resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  count = var.enabled_public_access ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  block_public_acls = false
  block_public_policy = false # Set to false to allow public policies if needed (e.g., for a static website)
  ignore_public_acls = false
  restrict_public_buckets = false # Set to false if you want the public policy to work
}

resource "aws_s3_bucket_cors_configuration" "s3_bucket_cors" {
  count = var.enabled_cors_config ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
    cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "GET"]
    allowed_origins = ["*"]
    expose_headers  = [""]
  }
}

/*
resource "aws_s3_bucket_policy" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  # Add a dependency to ensure public access block is applied first
  depends_on = [aws_s3_bucket_public_access_block.s3_bucket]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.s3_bucket.arn}/*"
      }
    ]
  })
}

# 1. Configure Object Ownership to enable ACLs
resource "aws_s3_bucket_ownership_controls" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    # 'BucketOwnerPreferred' or 'ObjectWriter' enables ACLs.
    # 'BucketOwnerEnforced' (default) disables ACLs.
    object_ownership = "BucketOwnerPreferred" 
  }
}

# 2. Apply the desired ACL
resource "aws_s3_bucket_acl" "example" {
  # This 'depends_on' ensures ownership controls are applied first
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket]

  bucket = aws_s3_bucket.s3_bucket.id
  # Example: set the canned ACL
  acl    = "private" 
}


resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = var.tags
} */