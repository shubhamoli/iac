terraform {
  required_version = "0.12.13"

  backend "s3" {
    bucket = "tf-state-memegen"
    key    = "memegen/prod"
    region = "${var.region}"
    profile = "${var.profile}"
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

resource "aws_security_group" "ssh_external" {
    description = "Allow Only SSH connections."
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags = {
        Name = "SSH-External"
    }
}

resource "aws_instance" "k8s_cluster_manager" {
    ami = "ami-040c7ad0a93be494e"        # Amazon Linux 2 x86
    availability_zone = "ap-south-1a"
    
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.memegen_prod.key_name}"
    
    vpc_security_group_ids = [
            "${aws_security_group.ssh_external.id}"
    ]
    
    disable_api_termination = true
    subnet_id = "${aws_subnet.public_subnet.id}"
    associate_public_ip_address = true
    source_dest_check = false
    iam_instance_profile = "${aws_iam_instance_profile.kops_req_profile.name}"

    ebs_block_device {
        device_name           = "/dev/sdg"
        volume_size           = 50
        volume_type           = "gp2"
        encrypted             = true
        delete_on_termination = false
    }

    tags = {
        Name = "K8s Cluster Manager"
    }

    # Note: Not adding any provisioner here. Can execute ansible-playbook here
    #       playbook is at ../ansible/playbooks/k8s_cluster_manager.yml"
}

resource "aws_eip" "k8s_cluster_manager" {
    instance = "${aws_instance.k8s_cluster_manager.id}"
    vpc = true
}
