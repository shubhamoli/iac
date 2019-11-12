terraform {
  required_version = "0.12.13"

  backend "s3" {
    bucket = "tf-state-memegen"
    key    = "memegen/prod"
    region = "ap-south-1"
    profile = "memegen"
    dynamodb_table = "terraform-lock"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
      name = "LockID"
      type = "S"
  }
}


resource "aws_key_pair" "memegen_prod" {
  key_name   = "Memegen-Prod"
  public_key = "${file(var.ssh_public_key)}"
}

