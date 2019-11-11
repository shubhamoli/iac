variable "region" {
  default = "ap-south-1"
}

variable "profile" {
  default = "memegen"
}


variable "availability_zones" {
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "172.30.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "172.30.0.0/24"
}
variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "172.30.1.0/24"
}

variable "ssh_public_key" {
  description = "location of public key"
  default = "~/.ssh/Memegen-Prod.pub"
}

variable "ssh_private_key" {
  description = "location of private SSH key"
  default = "~/.ssh/Memegen-Prod.pem"
}

variable "ansible_user" {
  default = "ec2-user"
}