# Initial Design and AWS Prerequisites

## Project setup

The project was built in US West (Oregon), `us-west-2`, using the AWS account available for the Moringa School DevOps capstone. The repository is [aws-blue-green-deployment](https://github.com/RURIGIMK/aws-blue-green-deployment).

## Design decisions

The implementation uses:
- One VPC with two public subnets in separate Availability Zones.
- An Internet Gateway and a public route table.
- One internet-facing Application Load Balancer.
- Two Amazon EC2 instances, one for Blue and one for Green.
- A separate ALB target group for each instance.
- Security groups that allow public HTTP traffic to the ALB and allow application traffic to EC2 only from the ALB security group.
- CloudWatch metrics, a dashboard and alarms.

The instances use Amazon Linux 2023 and Apache HTTP Server. The target groups check the `/health` path and expect HTTP 200.

## Scope

The lab was kept to EC2, the ALB, target groups, networking and CloudWatch. ECS, RDS, NAT Gateway, a custom domain and automated deployment services were not included.

## Deployed network

The VPC is `blue-green-vpc` with CIDR `10.0.0.0/16`. The two public subnets are `10.0.0.0/20` in `us-west-2a` and `10.0.16.0/20` in `us-west-2b`. Both use the public route table connected to the Internet Gateway.

See [the deployed architecture](../architecture/blue-green-architecture.md) for the resource layout and [the implementation report](../report/implementation-report.md) for the deployment and test results.
