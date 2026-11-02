#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-}"
AWS_REGION="${AWS_REGION:-us-west-2}"
LOAD_BALANCER_NAME="${LOAD_BALANCER_NAME:-blue-green-alb}"
BLUE_TG_NAME="${BLUE_TG_NAME:-blue-green-blue-tg}"
GREEN_TG_NAME="${GREEN_TG_NAME:-blue-green-green-tg}"

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

command -v aws >/dev/null 2>&1 || {
  echo "AWS CLI is required." >&2
  exit 1
}

LB_ARN="${LOAD_BALANCER_ARN:-$(aws elbv2 describe-load-balancers \
  --region "${AWS_REGION}" \
  --names "${LOAD_BALANCER_NAME}" \
  --query 'LoadBalancers[0].LoadBalancerArn' \
  --output text)}"

LISTENER_ARN="${LISTENER_ARN:-$(aws elbv2 describe-listeners \
  --region "${AWS_REGION}" \
  --load-balancer-arn "${LB_ARN}" \
  --query 'Listeners[?Port==`80`].ListenerArn | [0]' \
  --output text)}"

BLUE_TG_ARN="${BLUE_TG_ARN:-$(aws elbv2 describe-target-groups \
  --region "${AWS_REGION}" \
  --names "${BLUE_TG_NAME}" \
  --query 'TargetGroups[0].TargetGroupArn' \
  --output text)}"

GREEN_TG_ARN="${GREEN_TG_ARN:-$(aws elbv2 describe-target-groups \
  --region "${AWS_REGION}" \
  --names "${GREEN_TG_NAME}" \
  --query 'TargetGroups[0].TargetGroupArn' \
  --output text)}"

for resource_arn in "${LB_ARN}" "${LISTENER_ARN}" "${BLUE_TG_ARN}" "${GREEN_TG_ARN}"; do
  if [[ -z "${resource_arn}" || "${resource_arn}" == "None" ]]; then
    echo "Could not resolve one or more ALB resources. Check the region, resource names and AWS permissions." >&2
    exit 1
  fi
done

# The CLI expects default-actions as a JSON array.
ACTION_JSON="$(printf '[{"Type":"forward","ForwardConfig":{"TargetGroups":[{"TargetGroupArn":"%s","Weight":%s},{"TargetGroupArn":"%s","Weight":%s}]}}]' \
  "${BLUE_TG_ARN}" "${BLUE_WEIGHT}" "${GREEN_TG_ARN}" "${GREEN_WEIGHT}")"

echo "Setting ${LOAD_BALANCER_NAME} in ${AWS_REGION}: Blue=${BLUE_WEIGHT}%, Green=${GREEN_WEIGHT}%"
aws elbv2 modify-listener \
  --region "${AWS_REGION}" \
  --listener-arn "${LISTENER_ARN}" \
  --default-actions "${ACTION_JSON}"

echo "Listener update submitted. Check target health and test the application before considering the switch complete."
