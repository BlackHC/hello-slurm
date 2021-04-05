#!/bin/bash

mkdir -p $TMPDIR

SCRIPT_BASE="$(dirname -- "$0")"

./mount_scratch.sh || (echo "Failed to mount gigi's scratch directory!" && false)