#!/bin/bash

mkdir -p $TMPDIR

$SLURM_SCRIPT_INCLUDE/oatcloud/mount_scratch.sh || (echo "Failed to mount gigi's scratch directory!" && false)
