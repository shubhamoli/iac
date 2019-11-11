output "public-ip-aws_instace" {
  value = "${aws_instance.k8s_cluster_manager.public_ip}"
}