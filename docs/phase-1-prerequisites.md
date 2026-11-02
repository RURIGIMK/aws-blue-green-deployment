# Phase 1 Execution Checklist: Blank AWS Environment

## Confirmed project context

- AWS account: user confirms full permissions.
- Region: US West (Oregon), `us-west-2`.
- Starting point: blank project environment; no existing project resources or billing budgets/cost alerts are being reused.
- Repository: `RURIGIMK/aws-blue-green-deployment`.

## Architecture baseline

Use the account's default VPC if it exists and has suitable subnets in at least two Availability Zones. Only create a dedicated VPC if no suitable default VPC exists. Deploy one internet-facing Application Load Balancer and two EC2 instances (Blue and Green), each registered in a separate target group. EC2 instances will accept application traffic only from the ALB security group.

This design uses public EC2 instances for simplicity and cost control. Administrative access should use Systems Manager Session Manager if the required instance profile and connectivity are available. If not, use a temporary SSH rule restricted to the user's current public IP and remove it after use.

## Scope controls

Only implement resources and evidence that support the assignment deliverables. Do not create an AWS Budget, RDS, ECS, NAT Gateway, paid domain or optional automation. Clean up project resources after evidence has been collected.

## Phase 1 verification gates

- [ ] Confirm selected region is `us-west-2`.
- [ ] Confirm EC2, VPC, Elastic Load Balancing and CloudWatch console access.
- [ ] Inspect service quotas and available Availability Zones.
- [ ] Select an eligible low-cost EC2 instance type and supported AMI.
- [ ] Finalize network and security configuration.

## Screenshot evidence

Store screenshots in `screenshots/` using these filenames:
- `01-blue-green-network.png`: network configuration supporting the Blue/Green EC2 instances and ALB, if required as architecture evidence.

Do not capture passwords, access keys, account numbers, payment information or other secrets.

## Status

Architecture baseline documented. No AWS resources have been created. The user has confirmed a blank starting environment and region `us-west-2`. Budget creation is excluded because it is not a project deliverable.
