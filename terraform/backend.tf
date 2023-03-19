terraform {
  backend "s3" {
    bucket = "uthmanbucket"
    region = "us-east-1"
    key = "mykeypair/terraform.tfstate"
  }
}
