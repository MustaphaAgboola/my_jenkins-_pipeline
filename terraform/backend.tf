terraform {
  backend "s3" {
    bucket = ""new-bucket1122""
    region = "us-east-1"
    key = "my_key/terraform.tfstate"
  }
}