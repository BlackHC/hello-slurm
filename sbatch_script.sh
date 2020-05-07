#!/bin/bash
#SBATCH --job-name="hello-slurm"
#SBATCH --output="slurm-%j.batch.out"

# Example:
# sbatch sbatch_script.sh python hello.py

echo "SBATCH node: $(hostname)"
echo "Arguments: $@"

# Exit when any command fails
set -e

# Uncomment to enable tracing
set -x

export PATH="/scratch-ssd/oatml/miniconda3/bin:$PATH"
export CONDA_ENVS_PATH=/scratch-ssd/$USER/conda_envs
export CONDA_PKGS_DIRS=/scratch-ssd/$USER/conda_pkgs_cache
export TMPDIR=/scratch/${USER}/tmp

mkdir -p $TMPDIR

export ENV_PATH=/scratch-ssd/$USER/conda_envs/hello-slurm-${SLURM_JOB_ID}

srun --output="slurm-%j.%t.setup.out" --ntasks-per-node=1 ./_setup.sh "$ENV_PATH" && \
    srun --output="slurm-%j.%t.experiment.out" ./_run_experiment.sh "$ENV_PATH" "$@"
