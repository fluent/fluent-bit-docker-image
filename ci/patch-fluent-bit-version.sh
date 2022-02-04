#!/bin/bash

set -exuo pipefail

# Patches the Dockerfiles with the Fluent Bit version retrieved from the build tag.
# It assumes that the Fluent Bit version is the first part of the argument passed into the function.
# For example, calling `patch_fluent_bit_version "1.2.3-sumo-x.y.z"` will set Fluent Bit version to 1.2.3.
function patch_fluent_bit_version() {
    # Remove everything after first `-sumo` (including), e.g. `1.2.3-sumo-1-rc.1` => `1.2.3`
    fb_version=${1%%-*}
    # Check that Fluent Bit version is in correct format (SemVer)
    [[ "$fb_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || exit 10

    # Remove everything after first dot `.`, e.g. `1.2.3` => `1`
    fb_major=${fb_version%%.*}

    # Remove everything before first dot `.`, e.g. `1.2.3` => `2.3`
    fb_minor_patch=${fb_version#*.}
    # Remove everything after first dot `.`, e.g. `2.3` => `2`
    fb_minor=${fb_minor_patch%%.*}

    # Remove everything before last dot `.`, e.g. `1.2.3` => `3`
    fb_patch=${fb_version##*.}

    for arch in $amd64_arch $arm_arch $arm64_arch; do
        sed -i "s/ENV FLB_MAJOR .*/ENV FLB_MAJOR $fb_major/" "Dockerfile.${arch}"
        sed -i "s/ENV FLB_MINOR .*/ENV FLB_MINOR $fb_minor/" "Dockerfile.${arch}"
        sed -i "s/ENV FLB_PATCH .*/ENV FLB_PATCH $fb_patch/" "Dockerfile.${arch}"
        sed -i "s/ENV FLB_VERSION .*/ENV FLB_VERSION $fb_version/" "Dockerfile.${arch}"
    done
}

source "$(dirname "${BASH_SOURCE[0]}")/variables.sh"

patch_fluent_bit_version "${BUILD_TAG}"
