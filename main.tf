
provider "aws" {}

resource "aws_s3_bucket" "bucket" {
  name = "my-name"
}

resource "aws_instance" "what" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
}