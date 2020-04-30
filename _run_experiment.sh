#!/bin/bash
#eg run_experiment.sh /scratch-ssd/$USER/conda_envs/hello-slurm ...

# Uncomment to enable tracing
#set -x
echo "RUN_EXPERIMENT node $(hostname)"

ENV_PATH="$1"

export CONDA_ENVS_PATH=/scratch-ssd/$USER/conda_envs

source activate "$ENV_PATH"

echo "Running:"

python hello.py

# Clean up or other stuff