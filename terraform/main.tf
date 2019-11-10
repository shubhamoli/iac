terraform {
  required_version = "0.12.13"
}

resource "aws_key_pair" "memegen_prod" {
  key_name   = "Memegen-Prod"
  public_key = "${file(var.public_key)}"
}

resource "aws_security_group" "ssh_external" {
    description = "Allow Only SSH connections."
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
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

    tags {
        Name = "K8s Cluster Manager"
    }

    provisioner "local-exec" {
        command = <<EOT
            sleep 30;
            > ansible/hosts;
	        echo "${aws_instance.k8s_cluster_manager.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.ssh_private_key}" | tee -a ansible/hosts;
      	    export ANSIBLE_HOST_KEY_CHECKING=False;
	        ansible-playbook -u ${var.ansible_user} --private-key ${var.ssh_private_key} -i hosts ./ansible/playbooks/k8s_cluster_manager.yaml
    	    EOT
    }
    
    # Note: Not adding any destroy time provisioner
}

resource "aws_eip" "k8s_cluster_manager" {
    instance = "${aws_instance.k8s_cluster_manager.id}"
    vpc = true
}
