/* resource "aws_s3_bucket" "bucket_test1" {
  bucket = "my-bucket-032626-1"

  tags = {
    Name        = "juanruiz"
    Environment = "dev"
  }
} */

# Step 1: Create the S3 Bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = "cope-terraform-project-s3-state"
  lifecycle {
    prevent_destroy = true
  }
}

#Step 2: Enable Versioning
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }

}
#Step 3: Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}
#Step 4: Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


module "my-buckets3" {
  source = "./modules/bucket-s3"
  //for_each = var.loop-bucket
  bucket_name = "mynewbucket-202603826"
  //bucket_name = each.value

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}