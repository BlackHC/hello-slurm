#!/bin/bash
# _run_experiment.sh /scratch-ssd/$USER/conda_envs/hello-slurm ...

# Uncomment to enable tracing
#set -x
echo "Node $(hostname)"

ENV_PATH="$1"

export CONDA_ENVS_PATH=/scratch-ssd/$USER/conda_envs

source activate "$ENV_PATH"

python hello.py "$@"

# Clean up or other stuff