#!/bin/bash
# _run_experiment.sh /scratch-ssd/$USER/conda_envs/hello-slurm ...

echo "Node $(hostname)"

# Exit when any command fails
set -e

# Uncomment to enable tracing
set -x

ENV_PATH="$1"

export CONDA_ENVS_PATH=/scratch-ssd/$USER/conda_envs
export FASTAI_HOME=/scratch-ssd/$USER/.fastai

source activate "$ENV_PATH"

python "${@:2}"

# Clean up or other stuff