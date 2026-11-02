# Phase 1 Execution Checklist: Blank AWS Environment

## Confirmed project context

- AWS account: user confirms full permissions.
- Region: US West (Oregon), `us-west-2`.
- Starting point: blank project environment; no existing project resources or billing budgets/cost alerts are being reused.
- Repository: `RURIGIMK/aws-blue-green-deployment`.

## Architecture baseline

The environment has no VPCs. Create one project VPC with two public subnets in two distinct Availability Zones, an Internet Gateway and a public route table. Do not create private subnets, NAT Gateways or VPC endpoints for this baseline. Deploy one internet-facing Application Load Balancer and two EC2 instances (Blue and Green), each registered in a separate target group. EC2 instances will accept application traffic only from the ALB security group.

This design uses public EC2 instances for simplicity and cost control. Administrative access should use Systems Manager Session Manager if the required instance profile and connectivity are available. If not, use a temporary SSH rule restricted to the user's current public IP and remove it after use.

## Scope controls

Only implement resources and evidence that support the assignment deliverables. Do not create an AWS Budget, RDS, ECS, NAT Gateway, paid domain or optional automation. Clean up project resources after evidence has been collected.

## Phase 1 verification gates

- [ ] Create the project VPC and two public subnets in distinct Availability Zones.
- [ ] Attach an Internet Gateway and configure the public route table.
- [ ] Create the ALB and EC2 security groups with least-privilege inbound rules.
- [ ] Select an eligible EC2 instance type and supported AMI for both environments.

## Screenshot evidence

Store screenshots in `screenshots/` using these filenames:
- `01-blue-green-network.png`: network configuration supporting the Blue/Green EC2 instances and ALB, if required as architecture evidence.

Do not capture passwords, access keys, account numbers, payment information or other secrets.

## Status

Architecture baseline documented. User confirms there are no VPCs or existing project resources. Region is `us-west-2`. No AWS resources have been created. Budget creation and non-deliverable screenshots are excluded.
