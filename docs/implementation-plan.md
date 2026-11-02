# Implementation Plan and Completion Record

The project was implemented in phases. Each phase was checked before proceeding.

| Phase | Scope | Result |
|---|---|---|
| 1 | Architecture and AWS prerequisites | Complete |
| 2 | VPC, subnets, security groups, Blue instance and ALB | Complete |
| 3 | Green instance, target group and health validation | Complete |
| 4 | ALB traffic cutover to Green | Complete |
| 5 | CloudWatch dashboard and alarms | Complete |
| 6 | Manual rollback to Blue and recovery to Green | Complete |
| 7 | Repository documentation and submission evidence | Documentation in progress; screenshots captured at final stage |

## Completion checks

- [x] Blue and Green EC2 instances running.
- [x] Separate target groups created and registered.
- [x] Both target groups reported healthy.
- [x] ALB listener routes production traffic to Green.
- [x] Green application and health endpoint verified through the ALB.
- [x] Rollback to Blue performed and verified through the ALB.
- [x] Green restored and verified through the ALB.
- [x] Temporary Green validation listener rule removed.
- [x] CloudWatch dashboard created.
- [x] CPU alarms created for both EC2 instances.
- [x] ALB target response-time alarm created.
- [x] Healthy-host alarms created for both target groups.
- [ ] Final screenshots added to the repository.
- [ ] Final PDF report generated and added to the repository.

## Evidence rules

Only observed configuration and test results are described as completed. Screenshots should be captured from the live AWS console and stored in `screenshots/` using descriptive filenames. Do not include credentials, private keys or other secrets.
