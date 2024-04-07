terraform {
  backend "s3" {
    bucket = "<your_bucket_name>"
    key    = "<path/to/your/key"
    region = "<region>"
  }
}
