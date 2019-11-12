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
                "ec2:*",
                "route53domains:*",
                "elasticbeanstalk:DescribeEnvironments",
                "sns:ListSubscriptionsByTopic",
                "s3:GetBucketWebsite",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:DescribeAlarms",
                "sns:ListTopics",
                "s3:ListBucket",
                "organizations:DescribePolicy",
                "s3:*",
                "organizations:ListPolicies",
                "organizations:ListParents",
                "organizations:ListRoots",
                "organizations:DescribeAccount",
                "organizations:ListChildren",
                "elasticloadbalancing:DescribeLoadBalancers",
                "organizations:DescribeOrganization",
                "iam:*",
                "organizations:DescribeOrganizationalUnit",
                "organizations:ListPoliciesForTarget",
                "organizations:ListTargetsForPolicy",
                "route53:*",
                "cloudfront:ListDistributions",
                "s3:GetBucketLocation",
                "elasticloadbalancing:*",
                "autoscaling:*"
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