locals {
  location    = "us-east-1"
  environment = "test"
  product     = "icecream"


  tags = {
    Client = "xyz"
    Product    = local.product
    Env        = local.environment
    Region     = local.location
    ManagedBy  = "terraform"
  }
}
