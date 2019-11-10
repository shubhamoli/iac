resource "aws_iam_role" "kops_req" {
  name = "kops_req"
  
  # No leading white spaces below as there is a Bug in Terraform JSON parser it can't parse leading spaces in EOF injection
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Action": "sts:AssumeRole",
    "Principal": {
        "Service": "ec2.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
    }
]
}
    EOF

  tags = {
      Name = "Kops-Req"
  }
}

resource "aws_iam_instance_profile" "kops_req_profile" {
  name = "kops_req_profile"
  role = "${aws_iam_role.kops_req.name}"
}

resource "aws_iam_role_policy" "kops_req_policy" {
  name = "kops_req_policy"
  role = "${aws_iam_role.kops_req.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:CreateDhcpOptions",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:DescribeInstances",
                "ec2:ReplaceRouteTableAssociation",
                "ec2:DeleteVpcEndpoints",
                "ec2:AttachInternetGateway",
                "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
                "ec2:DeleteRouteTable",
                "route53domains:*",
                "elasticbeanstalk:DescribeEnvironments",
                "ec2:DeleteVpnGateway",
                "ec2:CreateNetworkInterfacePermission",
                "ec2:RevokeSecurityGroupEgress",
                "ec2:CreateRoute",
                "ec2:CreateInternetGateway",
                "ec2:DeleteInternetGateway",
                "ec2:UnassignPrivateIpAddresses",
                "ec2:DescribeKeyPairs",
                "sns:ListSubscriptionsByTopic",
                "s3:GetBucketWebsite",
                "ec2:CreateTags",
                "ec2:DescribeVpcClassicLinkDnsSupport",
                "ec2:ModifyNetworkInterfaceAttribute",
                "cloudwatch:GetMetricStatistics",
                "ec2:AssignPrivateIpAddresses",
                "ec2:DisassociateRouteTable",
                "ec2:ReplaceNetworkAclAssociation",
                "ec2:CreateVpcEndpointServiceConfiguration",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:CreateNetworkInterface",
                "ec2:DetachVpnGateway",
                "ec2:DescribeVpcEndpointServicePermissions",
                "ec2:CreateDefaultVpc",
                "cloudwatch:DescribeAlarms",
                "ec2:DeleteDhcpOptions",
                "ec2:DeleteNatGateway",
                "ec2:DescribeSubnets",
                "ec2:CreateSubnet",
                "ec2:ModifyVpcEndpoint",
                "ec2:DeleteNetworkAclEntry",
                "ec2:CreateVpnConnection",
                "ec2:DisassociateAddress",
                "ec2:DescribeMovingAddresses",
                "ec2:ModifyVpcEndpointServicePermissions",
                "ec2:MoveAddressToVpc",
                "ec2:CreateNatGateway",
                "ec2:DescribeFlowLogs",
                "ec2:DescribeRegions",
                "ec2:CreateVpc",
                "sns:ListTopics",
                "ec2:DescribeVpcEndpointServices",
                "s3:ListBucket",
                "ec2:DescribeVpcAttribute",
                "organizations:DescribePolicy",
                "ec2:ModifySubnetAttribute",
                "ec2:CreateDefaultSubnet",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeNetworkInterfaceAttribute",
                "ec2:DescribeVpcEndpointConnections",
                "ec2:DeleteNetworkAcl",
                "ec2:ReleaseAddress",
                "ec2:AssociateDhcpOptions",
                "ec2:AssignIpv6Addresses",
                "ec2:AttachVpnGateway",
                "ec2:AcceptVpcEndpointConnections",
                "s3:*",
                "ec2:DescribeClassicLinkInstances",
                "ec2:CreateVpnConnectionRoute",
                "ec2:DisassociateSubnetCidrBlock",
                "ec2:DescribeVpcEndpointConnectionNotifications",
                "ec2:DescribeSecurityGroups",
                "organizations:ListPolicies",
                "ec2:DeleteVpcEndpointConnectionNotifications",
                "ec2:RestoreAddressToClassic",
                "ec2:DeleteCustomerGateway",
                "ec2:DescribeVpcs",
                "ec2:EnableVgwRoutePropagation",
                "ec2:DisableVpcClassicLink",
                "ec2:DisableVpcClassicLinkDnsSupport",
                "organizations:ListParents",
                "ec2:ModifyVpcTenancy",
                "ec2:DescribeStaleSecurityGroups",
                "ec2:DeleteFlowLogs",
                "ec2:DeleteSubnet",
                "organizations:ListRoots",
                "ec2:ModifyVpcEndpointServiceConfiguration",
                "ec2:DetachClassicLinkVpc",
                "ec2:DeleteVpcPeeringConnection",
                "ec2:AcceptVpcPeeringConnection",
                "organizations:DescribeAccount",
                "ec2:DisableVgwRoutePropagation",
                "ec2:AssociateVpcCidrBlock",
                "ec2:ReplaceRoute",
                "ec2:RejectVpcPeeringConnection",
                "ec2:AssociateRouteTable",
                "ec2:DisassociateVpcCidrBlock",
                "organizations:ListChildren",
                "ec2:DescribeInternetGateways",
                "elasticloadbalancing:DescribeLoadBalancers",
                "organizations:DescribeOrganization",
                "ec2:ReplaceNetworkAclEntry",
                "ec2:ModifyVpcPeeringConnectionOptions",
                "ec2:CreateVpnGateway",
                "ec2:DescribeAccountAttributes",
                "ec2:UnassignIpv6Addresses",
                "ec2:DescribeNetworkInterfacePermissions",
                "ec2:DeleteVpnConnection",
                "ec2:CreateVpcPeeringConnection",
                "ec2:RejectVpcEndpointConnections",
                "ec2:DescribeNetworkAcls",
                "ec2:DescribeRouteTables",
                "ec2:EnableVpcClassicLink",
                "ec2:DescribeEgressOnlyInternetGateways",
                "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
                "ec2:CreateVpcEndpointConnectionNotification",
                "ec2:DescribeVpnConnections",
                "ec2:DescribeVpcPeeringConnections",
                "ec2:ResetNetworkInterfaceAttribute",
                "ec2:CreateRouteTable",
                "ec2:DeleteNetworkInterface",
                "ec2:DetachInternetGateway",
                "ec2:CreateCustomerGateway",
                "ec2:DescribeVpcEndpointServiceConfigurations",
                "ec2:DescribePrefixLists",
                "ec2:ModifyVpcEndpointConnectionNotification",
                "ec2:DescribeVpcClassicLink",
                "iam:*",
                "ec2:CreateFlowLogs",
                "ec2:AssociateSubnetCidrBlock",
                "ec2:DeleteVpc",
                "ec2:CreateEgressOnlyInternetGateway",
                "ec2:DescribeVpcEndpoints",
                "ec2:AssociateAddress",
                "ec2:DescribeVpnGateways",
                "ec2:DescribeAddresses",
                "ec2:DeleteTags",
                "ec2:DescribeDhcpOptions",
                "ec2:DeleteVpcEndpointServiceConfigurations",
                "ec2:DeleteNetworkInterfacePermission",
                "ec2:DescribeNetworkInterfaces",
                "ec2:CreateSecurityGroup",
                "ec2:CreateNetworkAcl",
                "organizations:DescribeOrganizationalUnit",
                "ec2:ModifyVpcAttribute",
                "organizations:ListPoliciesForTarget",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:AttachClassicLinkVpc",
                "ec2:DeleteEgressOnlyInternetGateway",
                "ec2:DetachNetworkInterface",
                "organizations:ListTargetsForPolicy",
                "ec2:DescribeTags",
                "ec2:DeleteRoute",
                "ec2:DescribeNatGateways",
                "ec2:DescribeCustomerGateways",
                "ec2:AllocateAddress",
                "ec2:DeleteVpnConnectionRoute",
                "ec2:DescribeSecurityGroupReferences",
                "ec2:CreateVpcEndpoint",
                "ec2:DeleteSecurityGroup",
                "route53:*",
                "cloudfront:ListDistributions",
                "ec2:AttachNetworkInterface",
                "ec2:EnableVpcClassicLinkDnsSupport",
                "ec2:CreateNetworkAclEntry",
                "s3:GetBucketLocation"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "apigateway:GET",
            "Resource": "arn:aws:apigateway:*::/domainnames"
        }
    ]
}
    EOF
}