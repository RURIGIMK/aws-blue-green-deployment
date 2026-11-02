# Phase 1 Execution Checklist: Blank AWS Environment

## Confirmed project context

- AWS account: user confirms full permissions.
- Region: US West (Oregon), `us-west-2`.
- Starting point: blank project environment; no existing project resources or billing budgets/cost alerts are being reused.
- Repository: `RURIGIMK/aws-blue-green-deployment`.

## Architecture baseline

Use the account's default VPC if it exists and has suitable subnets in at least two Availability Zones. Only create a dedicated VPC if no suitable default VPC exists. Deploy one internet-facing Application Load Balancer and two EC2 instances (Blue and Green), each registered in a separate target group. EC2 instances will accept application traffic only from the ALB security group.

This design uses public EC2 instances for simplicity and cost control. Administrative access should use Systems Manager Session Manager if the required instance profile and connectivity are available. If not, use a temporary SSH rule restricted to the user's current public IP and remove it after use.

## Cost guardrails

Before creating compute or load-balancing resources:
1. Open Billing and Cost Management and confirm the account's billing access.
2. Create an AWS Budget with a monthly cost limit agreed with the user.
3. Configure notifications at 50%, 80% and 100% of the budget, and a forecast notification if supported.
4. Understand that a budget is an alerting mechanism, not a hard spending cap.
5. Do not create NAT Gateways, RDS, paid domain names, or optional services in the baseline.
6. Stop or terminate lab resources after evidence is collected. Deleting EC2 instances alone does not delete the ALB, target groups, security groups, Elastic IPs or other billable resources.

## Phase 1 verification gates

- [ ] Confirm selected region is `us-west-2`.
- [ ] Confirm EC2, VPC, Elastic Load Balancing and CloudWatch console access.
- [ ] Inspect service quotas and available Availability Zones.
- [ ] Select an eligible low-cost EC2 instance type and supported AMI.
- [ ] Finalize network and security configuration.

## Screenshot evidence

Store screenshots in `screenshots/` using these filenames:
- `01-budget-created.png`: budget configuration and alert thresholds (hide account/payment details).
- `02-region-and-services.png`: console region selector and accessible services, if useful.
- `03-vpc-design.png`: later, after the VPC and subnets are created.

Do not capture passwords, access keys, account numbers, payment information or other secrets.

## Status

Architecture baseline documented. No AWS resources have been created. The user has confirmed a blank starting environment and region `us-west-2`. Budget creation is excluded because it is not a project deliverable.
