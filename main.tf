
provider "aws" {}

resource "aws_s3_bucket" "bucket" {
  name = "my-name"
}
