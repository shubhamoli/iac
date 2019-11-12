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

resource "aws_instance" "jenkins_server" {
    ami = "ami-040c7ad0a93be494e"        # Amazon Linux 2 x86
    availability_zone = "ap-south-1a"
    
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.memegen_prod.key_name}"
    
    vpc_security_group_ids = [
            "${aws_security_group.ssh_external.id}",
            "${aws_security_group.web.id}"
    ]
    
    subnet_id = "${aws_subnet.public_subnet.id}"
    associate_public_ip_address = true
    source_dest_check = false

    ebs_block_device {
        device_name           = "/dev/sdg"
        volume_size           = 50
        volume_type           = "gp2"
        encrypted             = true
        delete_on_termination = false
    }

    tags = {
        Name = "Jenkins master"
    }

    # Note: Not adding any provisioner here. Can execute ansible-playbook here
    #       playbook is at ../ansible/playbooks/k8s_cluster_manager.yml"
}

resource "aws_eip" "jenkins_server" {
    instance = "${aws_instance.jenkins_server.id}"
    vpc = true
}