locals {
  location    = "us-east"
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
