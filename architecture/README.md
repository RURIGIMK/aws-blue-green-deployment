# Architecture

The [architecture document](blue-green-architecture.md) describes the AWS resources used for the deployment, how the ALB routes traffic to the two target groups, the health-check settings and the final listener configuration.

The deployment runs in US West (Oregon), `us-west-2`. Blue and Green use separate EC2 instances and target groups in two Availability Zones. The ALB security group accepts public HTTP traffic, while the EC2 security group allows HTTP only from the ALB security group.
