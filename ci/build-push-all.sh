#!/bin/bash

set -exuo pipefail

DOT="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

source "$DOT/variables.sh"

"$DOT/patch-fluent-bit-version.sh"

"$DOT/build-push-${amd64_arch}.sh" &
readonly amd64_pid=$!

"$DOT/build-push-${arm_arch}.sh" &
readonly arm_pid=$!

"$DOT/build-push-${arm64_arch}.sh" &
readonly arm64_pid=$!

wait $amd64_pid
wait $arm_pid
wait $arm64_pid

"$DOT/push-multiplatform-manifest.sh"
