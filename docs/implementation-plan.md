# Implementation Record

| Stage | Work completed |
|---|---|
| Network | Created the VPC, two public subnets, Internet Gateway and public route table |
| Security | Created ALB and EC2 security groups |
| Blue environment | Launched the Blue EC2 instance and registered it in the Blue target group |
| Green environment | Launched the Green EC2 instance and registered it in the Green target group |
| Health checks | Confirmed both targets healthy using the `/health` endpoint |
| Traffic cutover | Changed the ALB listener to Green 100% |
| Rollback test | Changed the listener to Blue 100%, checked the Blue page and health endpoint, then restored Green |
| Monitoring | Created the CloudWatch dashboard and five alarms |
| Documentation | Added the architecture, scripts, monitoring notes, rollback procedure, implementation report and screenshot descriptions |

## Current deployment

The ALB listener sends 100% of production traffic to the Green target group. The Blue target group remains registered and can be selected for a manual rollback.

## Evidence in the repository

The [screenshots directory](../screenshots/) contains thirteen images covering the Blue and Green application pages, health endpoint, CloudWatch dashboard and alarms, VPC and subnet summaries, security-group summaries, EC2 instance list, target-group health summaries and final listener weights.

The images show the resource identities and selected states described in the [screenshot index](../screenshots/README.md). Some configuration details, including subnet CIDRs, security-group rule rows and registered-target rows, are not visible in the relevant captures. The screenshot index records these limitations.
