# Traffic Switching and Rollback Guide

## Purpose

This guide describes how to move production traffic between the Blue and Green target groups using the ALB listener's default forwarding action.

Final production routing after the completed test:
- Green target group: 100%
- Blue target group: 0%

Both targets should be healthy before a switch. Do not route production traffic to an environment that has not passed its health and application checks.

## Live application endpoints

- Application: [http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/](http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/)
- Health: [http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/health](http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/health)

Expected health response: `healthy`.

## Console procedure

1. Open the AWS console in `us-west-2`.
2. Navigate to **EC2 → Load Balancers**.
3. Select `blue-green-alb`.
4. Open **Listeners and rules**.
5. Select the HTTP listener on port 80 and choose **Edit listener**.
6. Under the default action, select **Forward to target groups**.
7. Set the target-group weights:
   - Green production: Blue `0`, Green `100`.
   - Rollback: Blue `100`, Green `0`.
8. Keep target group stickiness off for this demonstration.
9. Save the changes and wait for the listener update to complete.
10. Open the application endpoint and confirm the expected environment page.
11. Open `/health` and confirm the response is `healthy`.

## CLI procedure

The repository script `scripts/switch-traffic.sh` performs the same listener update. It requires `AWS_REGION` and `LISTENER_ARN`; target group ARNs have the deployed values as defaults.

```bash
export AWS_REGION=us-west-2
export LISTENER_ARN='arn:aws:elasticloadbalancing:us-west-2:325657596892:listener/app/blue-green-alb/ef513b7fdfdfbae0/9effab1f016ec5db'

# Roll back to Blue
./scripts/switch-traffic.sh blue
./scripts/health-check.sh http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/ BLUE

# Restore Green after recovery
./scripts/switch-traffic.sh green
./scripts/health-check.sh http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/ GREEN
```

The CLI command changes the default listener action and therefore affects live traffic. Verify account, region and ARNs before running it.

## Observed rollback and recovery test

The following was performed through the AWS console:

| Test stage | Listener weights | Observed result |
|---|---|---|
| Green production | Blue 0%, Green 100% | Green page served; `/health` returned `healthy` |
| Rollback to Blue | Blue 100%, Green 0% | Blue page served; `/health` returned `healthy` |
| Recovery to Green | Blue 0%, Green 100% | Green page served; `/health` returned `healthy` |

The test confirms that traffic can be moved back to the retained Blue environment and subsequently restored to Green. No instance was stopped or deliberately damaged. This is a manual rollback demonstration, not an automatic failure-detection or automatic rollback system.

## Operational cautions

- Confirm target health before switching traffic.
- Validate the application response as well as the health endpoint.
- Keep the known-good environment available until the new deployment has passed its observation period.
- Record the reason, time and operator for each production switch in a real operational environment.
- Do not delete the previous environment until rollback is no longer required.
