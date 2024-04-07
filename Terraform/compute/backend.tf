terraform {
  backend "s3" {
    bucket = local.s3_backed_bucket
    key    = local.s3_key
    region = "us-east-1"
  }
}