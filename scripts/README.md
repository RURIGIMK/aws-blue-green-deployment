# Deployment Scripts

This directory will contain scripts created and tested during implementation.

Planned scripts:

- `deploy-green.sh` - deploy the selected application version to Green.
- `health-check.sh` - test the Green application endpoint.
- `switch-traffic.sh` - update ALB forwarding configuration.
- `rollback.sh` - restore traffic to Blue.

Scripts that modify AWS resources will use explicit parameters or documented configuration variables. They must validate required inputs, fail safely, and avoid embedding credentials or resource identifiers that should remain configurable.

No operational deployment scripts are claimed to be complete at this stage. They will be added after the AWS resource design and identifiers are confirmed.
