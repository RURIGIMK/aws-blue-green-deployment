# Deployment and Validation Scripts

These scripts document the repeatable steps used by the EC2-based Blue-Green demonstration. The EC2 user-data scripts install Apache and write the environment-specific sample page. The validation and listener scripts use the public ALB endpoint and AWS CLI.

## Files

| File | Purpose |
|---|---|
| `blue-user-data.sh` | EC2 user data for the Blue web instance |
| `green-user-data.sh` | EC2 user data for the Green web instance |
| `health-check.sh` | Check the ALB application page and `/health` endpoint |
| `switch-traffic.sh` | Set the ALB listener to Green or Blue |

## Requirements

- AWS CLI v2 for traffic switching.
- An AWS CLI profile or role with permission to call `elasticloadbalancing:ModifyListener`.
- `curl` for health validation.
- Network access to the ALB DNS name.

No credentials are stored in these files. Authenticate through the AWS CLI outside the repository.

## Validate the live deployment

From the repository root:

```bash
chmod +x scripts/*.sh
./scripts/health-check.sh
```

The script defaults to the project's ALB endpoint and expects the Green environment in the final production state. You can pass a different ALB base URL as the first argument and expected environment as the second argument.

## Switch traffic

Set the region and listener ARN, then run:

```bash
export AWS_REGION=us-west-2
export LISTENER_ARN='arn:aws:elasticloadbalancing:us-west-2:325657596892:listener/app/blue-green-alb/ef513b7fdfdfbae0/9effab1f016ec5db'
./scripts/switch-traffic.sh blue
./scripts/health-check.sh
./scripts/switch-traffic.sh green
./scripts/health-check.sh
```

The script uses the actual target group ARNs as defaults. It changes only the listener's default forwarding action. Review and verify the selected region and resource ARNs before execution.

**Important:** Running the script changes live traffic. Use it only when authorized and when the target environment is healthy. This lab uses a manual rollback process and does not implement automatic failover.
