resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"
    enable_classiclink   = "false"
    
    tags = {
        Name = "Memegen-VPC"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "public_subnet" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "public_subnet" {
    subnet_id = "${aws_subnet.public_subnet.id}"
    route_table_id = "${aws_route_table.public_subnet.id}"
}

# Private subnet configured below
resource "aws_subnet" "private_subnet" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "ap-south-1b"

    tags = {
        Name = "Private Subnet"
    }
}



resource "aws_route_table" "private_subnet" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "Private Subnet"
    }
}

resource "aws_route_table_association" "private_subnet" {
    subnet_id = "${aws_subnet.private_subnet.id}"
    route_table_id = "${aws_route_table.private_subnet.id}"
}