# AWS Evidence Screenshots

Save screenshots of actual AWS Console configuration and observed test results in this directory.

## Naming convention

Use numbered, descriptive, lowercase filenames:

`NN-short-description.png`

Examples (capture only when the corresponding step is completed):

- `01-aws-region-and-account-context.png`
- `02-blue-ec2-instance-running.png`
- `03-blue-target-group-healthy.png`
- `04-alb-listener-forwarding-to-blue.png`
- `05-green-ec2-instance-running.png`
- `06-green-target-group-healthy.png`
- `07-green-smoke-test.png`
- `08-alb-traffic-shift-to-green.png`
- `09-cloudwatch-dashboard.png`
- `10-cloudwatch-alarms.png`
- `11-rollback-to-blue.png`

These are examples, not evidence of completed work. The exact capture point and final filename will be given during each implementation step.

## Screenshot quality and safety

- Keep the relevant AWS resource name, status, and configuration visible.
- Capture the full relevant panel where practical.
- Avoid including credentials, access keys, session tokens, or personal information.
- Redact account IDs and public IP addresses if they are not needed for assessment.
- Do not use mockups in place of AWS Console evidence.
