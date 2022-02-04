#!/bin/bash

set -exuo pipefail

if ! docker buildx ls | grep arm
then
    echo "Your Buildx seems to lack ARM architecture support"
    exit 1
fi

DOT="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "$DOT/variables.sh"

docker buildx build \
    --push \
    --platform=linux/arm64/v8 \
    --tag "${REPO_URL}:${BUILD_TAG}-${arm64_arch}" \
    --file "Dockerfile.${arm64_arch}" \
    .
