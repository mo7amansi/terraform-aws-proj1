resource "aws_s3_bucket" "proj1-s3" {
  bucket = "proj1-s3"
  force_destroy = true
  tags = {
    Name = "proj1-s3"
  }
}