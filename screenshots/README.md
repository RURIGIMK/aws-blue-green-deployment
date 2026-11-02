# Screenshots

These are the screenshots currently included with the project. They were captured from the running application and the AWS console.

## Application checks

### Blue Environment

![Blue Environment](Blue%20Environment.png)

The ALB served the Blue page during the Blue routing test. The page identifies the environment as BLUE.

### Production Green Environment

![Production Green Environment](Production%20Green%20Environment.png)

The ALB served the Green page after the production listener was switched to Green.

### Health endpoint

![Health endpoint](Healthy%20Status.png)

The browser shows the response from the ALB health endpoint: `healthy`.

## CloudWatch

### Dashboard

![CloudWatch dashboard](CloudWatch%20Dashboard.png)

The dashboard contains a CPU utilization chart for both EC2 instances and an ALB chart containing request count, target response time and target 4XX count.

### Alarms

![CloudWatch alarms](CloudWatch%20Alarms.png)

The alarm list shows five alarms:
- `Blue-No-Healthy-Hosts`
- `Green-No-Healthy-Hosts`
- `ALB-High-Response-Time`
- `Green-High-CPU`
- `Blue-High-CPU`

All five alarms are shown in the **OK** state in this capture. No alarm actions are configured.

## Evidence not shown in these images

The current screenshot set does not include the VPC and subnet configuration, security-group rules, EC2 instance list, target-group health details, ALB listener weights or the Blue rollback listener setting. Those steps are described in the [architecture](../architecture/blue-green-architecture.md), [rollback guide](../docs/traffic-switch-and-rollback.md) and [implementation report](../report/implementation-report.md).
