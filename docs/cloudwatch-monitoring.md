# CloudWatch Monitoring

## Dashboard

Dashboard name: `BlueGreenDeploymentMonitoring`

The dashboard was created in US West (Oregon), `us-west-2`.

Configured metric views include:
- EC2 `CPUUtilization` for Blue and Green.
- ALB `RequestCount`.
- ALB `TargetResponseTime`.
- ALB `HTTPCode_Target_4XX_Count`.

The available ALB metric list in the per-load-balancer category did not expose `HTTPCode_Target_5XX_Count` during configuration. The target-group category also exposed `HealthyHostCount` and `UnHealthyHostCount`, which were used for the host-health alarms. The dashboard's 4XX series is an additional error metric, not a replacement for 5XX monitoring.

## Alarms

| Alarm | Metric and dimensions | Evaluation | Threshold |
|---|---|---|---|
| `Blue-High-CPU` | `AWS/EC2 CPUUtilization`, Blue InstanceId | Average, 5 minutes, 1 of 1 | Greater than 80% |
| `Green-High-CPU` | `AWS/EC2 CPUUtilization`, Green InstanceId | Average, 5 minutes, 1 of 1 | Greater than 80% |
| `ALB-High-Response-Time` | `AWS/ApplicationELB TargetResponseTime`, LoadBalancer | Average, 5 minutes, 1 of 1 | Greater than 1 second |
| `Blue-No-Healthy-Hosts` | `AWS/ApplicationELB HealthyHostCount`, LoadBalancer and Blue TargetGroup | Minimum, 1 minute, 1 of 1 | Lower than 1 |
| `Green-No-Healthy-Hosts` | `AWS/ApplicationELB HealthyHostCount`, LoadBalancer and Green TargetGroup | Minimum, 1 minute, 1 of 1 | Lower than 1 |

For all alarms, missing data is treated as not breaching. No notification or remediation actions were configured. The alarms are visible in CloudWatch and can be connected to an SNS topic or incident workflow in a future extension.

## Interpretation

- CPU alarms identify sustained high compute utilization on either instance.
- Target response-time alarm identifies slow responses from registered targets.
- Healthy-host alarms identify when the corresponding target group has no healthy targets.
- Request count and 4XX metrics provide traffic and client-error context.

The thresholds are demonstration thresholds for this lab, not universal production service-level objectives. The alarms were created and observed in the CloudWatch console; a forced CPU, latency or target failure was not injected to test alarm transitions.

## Console links

- [CloudWatch dashboard](https://us-west-2.console.aws.amazon.com/cloudwatch/home?region=us-west-2#dashboards:name=BlueGreenDeploymentMonitoring)
- [CloudWatch alarms](https://us-west-2.console.aws.amazon.com/cloudwatch/home?region=us-west-2#alarmsV2:)

## Limitations

Default EC2 metrics do not include memory utilization. CloudWatch Agent was not installed because memory monitoring was outside the required baseline. The visible per-load-balancer metric group did not expose target 5XX count at the time of setup, so no 5XX alarm is claimed.
