#!/bin/bash
# Changes:
#   * trap to clean up the lockfile on crash
# Original:
# https://github.com/OATML/OATML-resources/tree/master/lab_servers/run_locked.sh
# Acquires a mutex and then runs the given program.
# There is a single mutex per user per machine, so only a single instance of
# run_locked.sh can be running at any one time.
# We use this to ensure only one "conda update" happens at once.
# Copy this file to /scratch-ssd/oatml/run_locked.sh on the compute nodes.
# This file is from:
# https://github.com/OATML/OATML-resources/tree/master/lab_servers/run_locked.sh

if ! [ -x "$(command -v lockfile)" ]; then
  echo "Error: lockfile not available, must install procmail." >&2
  exit 1
fi

if [ $# -eq 0 ]
  then
    echo "Usage run_locked.sh [command] [arguments]"
    exit
fi

# We have a single lock per user.
lockfile_name=/tmp/run_locked_$USER
echo "Waiting for lock $lockfile_name at `date`"
echo "(will force acquire the lock in 3 minutes)"
# Force acquire the lock after a timeout of 180 seconds. This prevents us
# getting stuck if the previous job is cancelled or crashes.
function cleanup() {
    rm -f $lockfile_name
    echo "Lock released at `date`"
}

lockfile -l 360 $lockfile_name
trap cleanup EXIT

echo "Lock acquired at `date`"

$1 "${@:2}"