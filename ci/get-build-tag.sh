#!/bin/bash

set -exuo pipefail

BUILD_TAG=$(git describe)
# Remove the `v` prefix from the tag
echo "${BUILD_TAG#v}"
