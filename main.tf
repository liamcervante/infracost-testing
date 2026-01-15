
provider "aws" {}

resource "aws_s3_bucket" "bucket" {
  name = "my-name"
}
resource "aws_s3_bucket" "bucket2" {
  name = "my-name-two"
}
