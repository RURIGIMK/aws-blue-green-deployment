#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://blue-green-alb-381653284.us-west-2.elb.amazonaws.com}"
EXPECTED_ENV="${2:-GREEN}"

BASE_URL="${BASE_URL%/}"

echo "Checking application at: ${BASE_URL}"
PAGE="$(curl --fail --silent --show-error --retry 5 --retry-delay 2 "${BASE_URL}/")"
HEALTH="$(curl --fail --silent --show-error --retry 5 --retry-delay 2 "${BASE_URL}/health")"

if [[ "${HEALTH}" != "healthy" ]]; then
  echo "Health check failed. Expected 'healthy', received: ${HEALTH}" >&2
  exit 1
fi

if ! grep -Fq "${EXPECTED_ENV}" <<< "${PAGE}"; then
  echo "Environment check failed. Expected page to contain: ${EXPECTED_ENV}" >&2
  exit 1
fi

echo "Application check passed: ${EXPECTED_ENV}"
echo "Health endpoint: ${HEALTH}"
