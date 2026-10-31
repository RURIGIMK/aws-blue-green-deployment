# Implementation Plan

Work proceeds one phase at a time. A phase is complete only after the configuration has been checked and its required evidence has been captured.

## Phase 1 - Architecture and prerequisites

- Confirm the AWS account and permitted services.
- Select the AWS Region.
- Review budget, free-tier eligibility and expected charges.
- Decide the web application used to distinguish Blue and Green.
- Finalize the network and ALB design.
- Record decisions before provisioning resources.

## Phase 2 - Blue environment and ALB foundation

- Create the required network and security configuration.
- Launch and verify the Blue EC2 environment.
- Create the Blue target group.
- Create the Application Load Balancer and listener.
- Route initial traffic to Blue.
- Verify the application through the ALB DNS endpoint.

## Phase 3 - Green deployment and validation

- Launch a separate Green EC2 environment.
- Deploy a visibly distinguishable application version.
- Create and register the Green target group.
- Configure and verify health checks.
- Run smoke tests before production traffic is shifted.

## Phase 4 - Traffic switching

- Configure listener forwarding to support Blue and Green.
- Demonstrate the initial Blue-only state.
- Shift traffic to Green.
- Verify the response version and target health.
- Record the actual traffic-switch behaviour.

## Phase 5 - CloudWatch monitoring

- Review available EC2 and ALB metrics.
- Create a deployment dashboard.
- Configure appropriate alarms.
- Verify that metrics and alarm states are observable.
- Document any metrics that require an agent or additional configuration.

## Phase 6 - Rollback and failure testing

- Prepare and verify the rollback procedure.
- Introduce only a controlled, reversible test failure.
- Observe the monitoring signal.
- Restore traffic to Blue.
- Verify that Blue serves requests successfully.
- Add automation only if it is justified and can be safely tested.

## Phase 7 - Final report and submission

- Capture any remaining evidence.
- Reconcile the documentation with actual AWS resources and test results.
- Record limitations, costs and lessons learned.
- Prepare the final PDF report.
- Review the public repository for secrets and incomplete claims.
- Confirm the final submission URL.

## Evidence rules

- Capture screenshots at the checkpoints specified during guided implementation.
- Use the exact filenames provided for each checkpoint.
- Store screenshots in the repository's `screenshots/` directory.
- Do not fabricate, edit to misrepresent, or label planned behaviour as observed behaviour.
- Redact account identifiers and other sensitive information where appropriate.
