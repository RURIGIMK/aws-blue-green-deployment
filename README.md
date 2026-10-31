# AWS Blue-Green Deployment

A practical implementation of a Blue-Green deployment strategy for a web application hosted on Amazon EC2 and served through an Application Load Balancer (ALB).

The project is being developed in modular phases. Each phase will be verified before the next begins. Screenshots and notes will record the actual AWS configuration and observed results.

## Project objectives

- Maintain separate Blue (current) and Green (new) web environments.
- Register each environment in its own ALB target group.
- Deploy and validate Green before directing production traffic to it.
- Switch traffic through the ALB, with a controlled rollback path to Blue.
- Monitor deployment health and application behaviour using Amazon CloudWatch.
- Document the implementation so the process can be repeated.

## Planned architecture

```mermaid
flowchart TB
    U[Users] --> ALB[Application Load Balancer]
    ALB --> L[Listener and forwarding rules]
    L --> TB[Blue Target Group]
    L --> TG[Green Target Group]
    TB --> B1[Blue EC2 instance(s)]
    TG --> G1[Green EC2 instance(s)]
    B1 --> APPB[Current application version]
    G1 --> APPG[New application version]
    CW[Amazon CloudWatch] -. monitors .-> B1
    CW -. monitors .-> G1
    CW -. alarms .-> RB[Rollback procedure]
    RB -. restores traffic to .-> TB
```

The diagram is a target design, not evidence that AWS resources have already been created. The final architecture will be updated to match the deployed configuration.

## Repository structure

| Path | Purpose |
|---|---|
| `architecture/` | Architecture diagrams and design notes |
| `docs/` | Implementation, traffic switching, validation and rollback guides |
| `scripts/` | Deployment, health-check, traffic-switch and rollback scripts |
| `screenshots/` | Evidence captured from the actual AWS environment |
| `report/` | Final implementation report |

## Implementation status

| Phase | Scope | Status |
|---|---|---|
| 0 | Repository setup and project documentation | In progress |
| 1 | Architecture decisions and AWS prerequisites | Not started |
| 2 | Blue environment and ALB foundation | Not started |
| 3 | Green environment and validation | Not started |
| 4 | Traffic switching | Not started |
| 5 | CloudWatch monitoring and alarms | Not started |
| 6 | Rollback and failure testing | Not started |
| 7 | Final documentation and submission review | Not started |

## Expected evidence

Screenshots will be stored in `screenshots/` using descriptive, numbered filenames. Each screenshot will be accompanied by a short note explaining what it demonstrates. Only observed results will be reported as completed.

## Cost and safety

AWS resources can incur charges even when idle. Resource sizes, region, estimated costs, and cleanup decisions will be reviewed before resources are created. Never commit AWS access keys, passwords, private keys, account credentials, or other secrets to this repository.

## Submission

The intended submission is this GitHub repository, supported by a final PDF report in `report/`. The report and README will distinguish planned configuration from resources and tests that were actually completed.

## Current status

Repository scaffolding and planning documentation are being prepared. No AWS infrastructure has been provisioned or tested yet.
