#!/bin/bash
# _run_experiment.sh ...
# EXPECTS CURRENT_CONDA_ENV_PATH

echo "Node $(hostname)"

# Exit when any command fails
set -e

# Uncomment to enable tracing
set -x

source activate "$CURRENT_CONDA_ENV_PATH"

python "${@}"

