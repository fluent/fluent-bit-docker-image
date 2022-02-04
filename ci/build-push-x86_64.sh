#!/bin/bash

set -exuo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/variables.sh"

docker buildx build \
    --push \
    --platform=linux/amd64 \
    --tag "${REPO_URL}:${BUILD_TAG}-${amd64_arch}" \
    --file "Dockerfile.${amd64_arch}" \
    .
