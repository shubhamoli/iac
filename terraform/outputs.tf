output "public-ip-aws_instace" {
  value = "${aws_instance.k8s_cluster_manager.public_ip}"
}

output "elastic-ip-aws_instace" {
  value = "${aws_eip.k8s_cluster_manager.public_ip}"
}

output "public-ip-jenkins_server" {
  value = "${aws_instance.jenkins_server.public_ip}"
}

output "elastic-ip-jenkins_server" {
  value = "${aws_eip.jenkins_server.public_ip}"
}

