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

if [ $# -eq 0 ]
  then
    echo "Usage _run_locked.sh [command] [arguments]"
    exit
fi

# We have a single lock per user.
LOCKFILE_NAME=$TMPDIR/run_locked_$USER

# Force acquire the lock after a timeout of 180 seconds. This prevents us
# getting stuck if the previous job is cancelled or crashes.
function cleanup() {
    rm -f $LOCKFILE_NAME
    echo "Lock released at `date`"
}

LOCK_DURATION=$((180 + 15 * ($RANDOM % 10)))
echo "Waiting for lock $LOCKFILE_NAME at `date`"
echo "(will force acquire the lock in 3 minutes)"

# Lock for 6 minutes
if which lockfile; then
    lockfile -l $LOCK_DURATION $LOCKFILE_NAME
else
    echo "Warning: 'lockfile' (install procmail? not found! Continuing, assuming no clashes!"
fi

trap cleanup EXIT

echo "Lock acquired at `date`"

$1 "${@:2}"
