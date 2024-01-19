#!/usr/bin/env bash
set -eux

# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"
/bin/bash "$CUR_DIR/setup-links.bash"
