provider "aws" {
  profile     = "${var.profile}"
  region      = "${var.region}"
  max_retries = 5
  allowed_ids = ["905772465222"]
}
