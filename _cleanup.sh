#!/bin/bash
# _cleanup.sh /scratch-ssd/$USER/conda_envs/hello-slurm

echo "Node $(hostname)"

# Exit when any command fails
set -e

# Uncomment to enable tracing
set -x

ENV_PATH="$1"

conda env remove -q -y -p "$ENV_PATH" 