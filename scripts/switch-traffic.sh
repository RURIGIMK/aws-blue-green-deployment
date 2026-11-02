#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-}"

AWS_REGION="${AWS_REGION:-us-west-2}"
LISTENER_ARN="${LISTENER_ARN:-arn:aws:elasticloadbalancing:us-west-2:325657596892:listener/app/blue-green-alb/ef513b7fdfdfbae0/9effab1f016ec5db}"
BLUE_TG_ARN="${BLUE_TG_ARN:-arn:aws:elasticloadbalancing:us-west-2:325657596892:targetgroup/blue-green-blue-tg/46008680c6484925}"
GREEN_TG_ARN="${GREEN_TG_ARN:-arn:aws:elasticloadbalancing:us-west-2:325657596892:targetgroup/blue-green-green-tg/a1ffaecf78b51d86}"

if [[ "${ENVIRONMENT}" == "blue" ]]; then
  BLUE_WEIGHT=100
  GREEN_WEIGHT=0
elif [[ "${ENVIRONMENT}" == "green" ]]; then
  BLUE_WEIGHT=0
  GREEN_WEIGHT=100
else
  echo "Usage: $0 {blue|green}" >&2
  exit 2
fi

if ! command -v aws >/dev/null 2>&1; then
  echo "AWS CLI is required." >&2
  exit 1
fi

ACTION_JSON="$(printf '{"Type":"forward","ForwardConfig":{"TargetGroups":[{"TargetGroupArn":"%s","Weight":%s},{"TargetGroupArn":"%s","Weight":%s}]}}' \
  "${BLUE_TG_ARN}" "${BLUE_WEIGHT}" "${GREEN_TG_ARN}" "${GREEN_WEIGHT}")"

echo "Updating listener in ${AWS_REGION}: Blue=${BLUE_WEIGHT}%, Green=${GREEN_WEIGHT}%"
aws elbv2 modify-listener \
  --region "${AWS_REGION}" \
  --listener-arn "${LISTENER_ARN}" \
  --default-actions "${ACTION_JSON}"

echo "Listener update submitted. Verify target health and test the application endpoint."
