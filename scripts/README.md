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
- An AWS CLI profile or role with permission to describe the ALB resources and call `elasticloadbalancing:ModifyListener`.
- `curl` for health validation.
- Network access to the ALB DNS name.

No credentials or account-specific resource ARNs are stored in these files. Authenticate through the AWS CLI outside the repository.

## Validate the live deployment

From the repository root:

```bash
chmod +x scripts/*.sh
./scripts/health-check.sh
```

The script defaults to the project's ALB endpoint and expects the Green environment in the final production state. You can pass a different ALB base URL as the first argument and expected environment as the second argument.

## Switch traffic

The listener and target-group ARNs are discovered by resource name through AWS CLI. Set the region, then run:

```bash
export AWS_REGION=us-west-2
./scripts/switch-traffic.sh blue
./scripts/health-check.sh
./scripts/switch-traffic.sh green
./scripts/health-check.sh
```

The default resource names are `blue-green-alb`, `blue-green-blue-tg` and `blue-green-green-tg`. They can be overridden with `LOAD_BALANCER_NAME`, `BLUE_TG_NAME` and `GREEN_TG_NAME`. The script changes only the listener's default forwarding action.

**Important:** Running the script changes live traffic. Use it only when authorized and when the target environment is healthy. This lab uses a manual rollback process and does not implement automatic failover.
