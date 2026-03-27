/* resource "aws_s3_bucket" "bucket_test1" {
  bucket = "my-bucket-032626-1"

  tags = {
    Name        = "juanruiz"
    Environment = "dev"
  }
} */


module "my-buckets3" {
  source   = "./modules/bucket-s3"
  for_each = var.loop-bucket
  //bucket_name = "mynewbucket-20260326"
  bucket_name = each.value

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}