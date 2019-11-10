# Note: Credentails will be auto-fetched using MetaData API
#       Please attach an appropriate IAM role with the instance

provider "aws" {
  profile     = "${var.profile}"
  region      = "${var.region}"
  max_retries = 5
  allowed_ids = ["905772465222"]
}
