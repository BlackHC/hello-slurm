#!/bin/bash
#eg run_experiment.sh /scratch-ssd/$USER/conda_envs/hello-slurm ...
ENV_PATH="$1"

export PATH="/scratch-ssd/oatml/miniconda3/bin:$PATH"

conda activate "$ENV_PATH"
python hello.py

# Copy logs etc