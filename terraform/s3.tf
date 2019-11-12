
resource "aws_s3_bucket" "memegen-kops-cluster-state" {
  bucket = "memegen-kops-cluster-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "memegen-kops-cluster-state"
    Environment = "Prod"
  }
}
