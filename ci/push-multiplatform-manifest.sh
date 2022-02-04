#!/bin/bash

set -exuo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/variables.sh"

docker manifest create --amend \
    "${REPO_URL}:${BUILD_TAG}" \
    "${REPO_URL}:${BUILD_TAG}-${amd64_arch}" \
    "${REPO_URL}:${BUILD_TAG}-${arm_arch}" \
    "${REPO_URL}:${BUILD_TAG}-${arm64_arch}"

docker manifest push "${REPO_URL}:${BUILD_TAG}"
