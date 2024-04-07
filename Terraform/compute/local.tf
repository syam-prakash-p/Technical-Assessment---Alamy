locals {
  location    = "us-east-1"
  environment = "test"
  product     = "icecream"
  s3_backed_bucket = "<your_bucket_name>"
  s3_key = "<path/to/your/key"

  tags = {
    Client = "xyz"
    Product    = local.product
    Env        = local.environment
    Region     = local.location
    ManagedBy  = "terraform"
  }
}
