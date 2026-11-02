# Blue-Green Deployment Implementation Report

**Project:** AWS Blue-Green Deployment Strategy  
**Student:** Rurigi Maina Kariuki  
**AWS Region:** US West (Oregon), `us-west-2`  
**Repository:** [RURIGIMK/aws-blue-green-deployment](https://github.com/RURIGIMK/aws-blue-green-deployment)

## 1. Objective

The project demonstrates a Blue-Green deployment using two Amazon EC2 web environments behind an Application Load Balancer. The new environment can be tested before production traffic is moved to it. The previous environment remains available so traffic can be moved back if necessary.

## 2. Architecture and resources

The implementation uses one VPC, two public subnets in separate Availability Zones, an internet-facing Application Load Balancer, two EC2 instances, two target groups and Amazon CloudWatch.

| Component | Implemented resource |
|---|---|
| VPC | `blue-green-vpc`, `10.0.0.0/16` |
| Public subnet A | `10.0.0.0/20`, `us-west-2a` |
| Public subnet B | `10.0.16.0/20`, `us-west-2b` |
| Load balancer | `blue-green-alb`, HTTP port 80 |
| Blue compute | `blue-web-1` |
| Green compute | `green-web-1` |
| Target groups | `blue-green-blue-tg`, `blue-green-green-tg` |
| Health check | HTTP `/health`, expected status 200 |

Both instances run Amazon Linux 2023 with Apache HTTP Server. Each serves a page that identifies its environment. The EC2 security group accepts HTTP traffic only from the ALB security group.

## 3. Deployment and validation

Blue was deployed first and checked through the ALB. Green was then deployed separately, registered in its target group and checked using the target-group health status and application endpoint. A temporary query-string rule was used to test Green while the default route still pointed to Blue. The temporary rule was removed after the test.

The ALB default action was changed to Green 100% and Blue 0%. The live ALB returned the Green page and the `/health` endpoint returned `healthy`.

- [Live application](http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/)
- [Live health endpoint](http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/health)

## 4. Traffic switching and rollback

A manual rollback test was performed by changing the ALB listener to Blue 100% and Green 0%. The ALB served the Blue page and its health endpoint returned `healthy`. The listener was then restored to Green 100% and Blue 0%. Green was checked again through both the application and health endpoints.

This test confirms that traffic could be moved back to the retained Blue environment and then returned to Green. No instance was stopped or deliberately damaged. Automatic rollback and failure-triggered automation were not configured.

## 5. Monitoring

A CloudWatch dashboard named `BlueGreenDeploymentMonitoring` was created. It includes EC2 CPU metrics and available ALB request, response-time and target 4XX metrics.

Five alarms were created:

1. `Blue-High-CPU`: Blue CPU utilization above 80%.
2. `Green-High-CPU`: Green CPU utilization above 80%.
3. `ALB-High-Response-Time`: average target response time above 1 second.
4. `Blue-No-Healthy-Hosts`: Blue minimum healthy host count below 1.
5. `Green-No-Healthy-Hosts`: Green minimum healthy host count below 1.

The selected per-load-balancer metric list did not show target 5XX count during setup. The dashboard includes target 4XX count, but this is not a replacement for 5XX monitoring. Memory monitoring was not configured because it requires an additional agent and was outside the project scope. Alarm notifications and automatic remediation actions were not configured.

## 6. Screenshot evidence

Five screenshots are included in the repository:

| Image | Evidence |
|---|---|
| [Blue Environment](../screenshots/Blue%20Environment.png) | The Blue application page was served through the ALB. |
| [Production Green Environment](../screenshots/Production%20Green%20Environment.png) | The Green application page was served through the ALB. |
| [Healthy Status](../screenshots/Healthy%20Status.png) | The ALB health endpoint returned `healthy`. |
| [CloudWatch Dashboard](../screenshots/CloudWatch%20Dashboard.png) | CPU utilization for both instances and the selected ALB metrics are visible. |
| [CloudWatch Alarms](../screenshots/CloudWatch%20Alarms.png) | All five configured alarms are shown in the OK state. |

The screenshots do not show the VPC, security-group rules, EC2 instance list, target-group health details or listener weights. Those configurations and the rollback test are described in this report and the architecture and rollback documents.

## 7. Reliability and limitations

Both environments remain registered in separate target groups. The listener can be changed between them without rebuilding the instances. The rollback test confirmed that Blue continued serving requests after Green had become the production environment.

The implementation is limited to the required web tier. It does not include ECS, RDS, NAT Gateway, a custom domain, HTTPS certificate, automated deployment pipeline or automatic rollback. The sample application is static and demonstrates routing and environment identification rather than application business logic.

The lab uses HTTP for simplicity. A production implementation should use HTTPS, consider private application subnets, provide controlled administrative access, configure alert notifications and test automated recovery.

## 8. Conclusion

The Blue-Green deployment was implemented using EC2, separate target groups and an ALB. Green was validated and moved into production. A manual rollback to Blue was tested, after which Green was restored and checked again. CloudWatch monitoring was configured with a dashboard and five alarms. The final listener state sends all production traffic to Green.

## 9. Project files

- [Main README](../README.md)
- [Architecture](../architecture/blue-green-architecture.md)
- [CloudWatch monitoring](../docs/cloudwatch-monitoring.md)
- [Traffic switch and rollback procedure](../docs/traffic-switch-and-rollback.md)
- [Deployment and validation scripts](../scripts/README.md)
- [Screenshot descriptions](../screenshots/README.md)
