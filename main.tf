provider "aws" {
  access_key = "AKIAROKRQG5ZZX5RIVPB"
  secret_key = "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"
  region     = "us-east-1"
}

resource "aws_s3_bucket" "aws"{
  bucket = "{var.bucket_name}"
  acl    = "private"

  lifecycle_rule {
    id      = "log"
    enabled = true

    prefix = "log/"

    tags = {
      rule      = "log"
      autoclean = "true"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA" 
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}