#!/bin/bash

set -exuo pipefail

if ! docker buildx ls | grep arm
then
    echo "Your Buildx seems to lack ARM architecture support"
    exit 1
fi

source "$(dirname "${BASH_SOURCE[0]}")/variables.sh"

docker buildx build \
    --push \
    --platform=linux/arm/v7 \
    --tag "${REPO_URL}:${BUILD_TAG}-${arm_arch}" \
    --file "Dockerfile.${arm_arch}" \
    .
