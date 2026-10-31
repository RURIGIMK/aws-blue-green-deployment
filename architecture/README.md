# Architecture

This directory contains the Blue-Green architecture diagram and design decisions.

The architecture must reflect the actual deployed resources. Before implementation, the design will identify:

- AWS Region and network layout.
- Blue and Green EC2 instances.
- Blue and Green ALB target groups.
- ALB listener and forwarding behaviour.
- Security group relationships.
- Health-check path, protocol and success codes.
- CloudWatch metrics, alarms and rollback signal.

The root README contains the initial conceptual traffic-flow diagram. Replace or supplement it with the final architecture after the AWS configuration has been verified.

Do not include account IDs, public IP addresses, private addresses, credentials, or other sensitive information in public diagrams.
