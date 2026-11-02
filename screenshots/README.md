# AWS Evidence Screenshots

Capture the following screenshots together at the final evidence stage. Use the actual AWS console and live application. Save the images in this directory with the exact filenames below.

## Required evidence

| Filename | Capture |
|---|---|
| `01-vpc-and-subnets.png` | VPC details showing the project VPC and both public subnets in separate Availability Zones |
| `02-security-groups.png` | ALB and EC2 security-group rules, showing HTTP access to EC2 restricted to the ALB security group |
| `03-blue-green-ec2-instances.png` | EC2 instances list showing both Blue and Green instances running |
| `04-blue-target-group-healthy.png` | Blue target group with its registered target Healthy |
| `05-green-target-group-healthy.png` | Green target group with its registered target Healthy |
| `06-alb-listener-green-production.png` | ALB HTTP:80 default action showing Green 100% and Blue 0% |
| `07-live-green-application.png` | Browser showing the live Green Environment page through the ALB |
| `08-live-green-health-check.png` | Browser showing the ALB `/health` endpoint response `healthy` |
| `09-cloudwatch-dashboard.png` | CloudWatch dashboard `BlueGreenDeploymentMonitoring` with its saved metric widgets |
| `10-cloudwatch-alarms.png` | CloudWatch alarm list showing the five project alarms |
| `11-rollback-blue-validation.png` | Evidence of the rollback test: listener set to Blue 100%, Green 0%, and Blue application page or health response |
| `12-final-green-restoration.png` | Final listener weights Green 100%, Blue 0%, with the Green application and health endpoint verified |

## Capture guidance

- Keep the AWS resource name, status and relevant configuration visible.
- For browser tests, keep the ALB URL visible where practical.
- For listener screenshots, include both target groups and their weights.
- For the dashboard, ensure the dashboard name and chart titles are visible.
- For alarms, show all five alarm names and their states if the page layout permits.
- Do not include credentials, access keys, session tokens or other secrets.
- Do not fabricate, edit to misrepresent, or use mockups in place of AWS Console evidence.

The final README and report already link to the live application, health endpoint, AWS console views and the relevant documentation. Screenshots provide supporting evidence of the deployed configuration and observed tests.
