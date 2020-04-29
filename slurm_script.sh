#!/bin/bash
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --job-name="hello-slurm"

ENV_PATH=/scratch-ssd/$USER/conda_envs/hello-slurm

hostname

srun --ntasks-per-node=1 ./setup.sh "$ENV_PATH"
srun ./run_experiment "$ENV_PATH" "$@"
