# Blue-Green Deployment Implementation Report

**Project:** AWS Blue-Green Deployment Strategy  
**Student:** Rurigi Maina Kariuki  
**AWS Region:** US West (Oregon), `us-west-2`  
**Repository:** [RURIGIMK/aws-blue-green-deployment](https://github.com/RURIGIMK/aws-blue-green-deployment)

## 1. Objective

The objective was to implement and validate a Blue-Green deployment strategy using two Amazon EC2 web environments behind an Application Load Balancer. The design provides a controlled way to deploy a new environment, route production traffic to it after validation, and restore traffic to the previous environment if required.

## 2. Architecture and resources

The implementation uses one VPC, two public subnets in separate Availability Zones, an internet-facing Application Load Balancer, two EC2 instances, two target groups and Amazon CloudWatch.

| Component | Implemented resource |
|---|---|
| VPC | `blue-green-vpc`, `10.0.0.0/16` |
| Public subnet A | `10.0.0.0/20`, `us-west-2a` |
| Public subnet B | `10.0.16.0/20`, `us-west-2b` |
| Load balancer | `blue-green-alb`, HTTP port 80 |
| Blue compute | `blue-web-1`, `i-0b5bb01e9de1eb394` |
| Green compute | `green-web-1`, `i-09be9ec1beab95ecb` |
| Target groups | `blue-green-blue-tg`, `blue-green-green-tg` |
| Health check | HTTP `/health`, expected status 200 |

Both instances run Amazon Linux 2023 with Apache HTTP Server. Each serves a distinct static page identifying its environment. The EC2 security group accepts HTTP only from the ALB security group.

## 3. Deployment and validation

Blue was deployed first and verified through the ALB. Green was then deployed separately, registered in its target group and checked using the target-group health status and application endpoint. A temporary query-string rule was used to test Green while the default route still pointed to Blue. That temporary rule was removed after the test.

The ALB default action was then changed to Green 100% and Blue 0%. The live ALB returned the Green page and the `/health` endpoint returned `healthy`.

- [Live application](http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/)
- [Live health endpoint](http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com/health)

## 4. Traffic switching and rollback

A manual rollback test was performed by changing the ALB listener to Blue 100% and Green 0%. The ALB served the Blue page and its health endpoint returned `healthy`. The listener was then restored to Green 100% and Blue 0%. Green was verified again through both the application and health endpoints.

This demonstrates successful manual traffic rollback and recovery. It does not demonstrate automatic rollback or failure-triggered automation because no automated controller was configured and no instance failure was injected.

## 5. Monitoring

A CloudWatch dashboard named `BlueGreenDeploymentMonitoring` was created. It includes EC2 CPU metrics and available ALB request, response-time and target 4XX metrics.

Five alarms were created:

1. `Blue-High-CPU`: Blue CPU utilization above 80%.
2. `Green-High-CPU`: Green CPU utilization above 80%.
3. `ALB-High-Response-Time`: average target response time above 1 second.
4. `Blue-No-Healthy-Hosts`: Blue minimum healthy host count below 1.
5. `Green-No-Healthy-Hosts`: Green minimum healthy host count below 1.

The selected per-load-balancer metric list did not expose target 5XX count during configuration. The dashboard includes target 4XX count, but this is not represented as a substitute for 5XX monitoring. Memory monitoring was not configured because it requires an additional agent and was outside the baseline scope. Alarm notifications and automatic remediation actions were not configured.

## 6. Reliability and limitations

The implementation keeps both environments registered in separate target groups. The listener can be switched between them without rebuilding the instances. The rollback test confirmed that Blue continued serving requests after Green had become production.

The implementation is intentionally limited to the required web tier. It does not include ECS, RDS, NAT Gateway, a custom domain, HTTPS certificate, automatic deployment pipeline or automatic rollback. The sample application is static and is intended to demonstrate routing and environment identification rather than application business logic.

The lab uses HTTP for simplicity. A production implementation should use HTTPS, private application subnets where appropriate, stronger application-level readiness checks, controlled administrative access, notification actions and tested automation.

## 7. Conclusion

The Blue-Green deployment was implemented using EC2, separate target groups and an ALB. Green was validated and promoted to production. A manual rollback to Blue was successfully tested, after which Green was restored and revalidated. CloudWatch monitoring was configured with a dashboard and five alarms. The final production listener state is Green 100%, Blue 0%.

## 8. Supporting project links

- [Main README and examiner links](../README.md)
- [Architecture](../architecture/blue-green-architecture.md)
- [CloudWatch monitoring](../docs/cloudwatch-monitoring.md)
- [Traffic switch and rollback procedure](../docs/traffic-switch-and-rollback.md)
- [Deployment and validation scripts](../scripts/README.md)
- [Screenshot evidence index](../screenshots/README.md)
