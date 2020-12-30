#!/bin/bash
#SBATCH --job-name="hello-slurm"
#SBATCH --cpus-per-task=4
#SBATCH --output="slurm-%j.batch.out"

echo "SBATCH node: $(hostname)"

# exit when any command fails
set -e

# Uncomment to enable tracing
set -x

export PATH="/scratch-ssd/oatml/miniconda3/bin:$PATH"
export CONDA_ENVS_PATH=/scratch-ssd/$USER/conda_envs
export CONDA_PKGS_DIRS=/scratch-ssd/$USER/conda_pkgs_cache
export TMPDIR=/scratch-ssd/${USER}/tmp

# This is a configuration option for _setup.sh
export PYTHON_VERSION=3.8

mkdir -p $TMPDIR

export ENV_PATH=/scratch-ssd/$USER/conda_envs/job-$SLURM_JOB_ID

function cleanup() {
    ./_cleanup.sh "$ENV_PATH"
}
trap cleanup EXIT

# Only one task/node when running with job arrays.
#srun --output="slurm-%j.%t.setup.out" --ntasks-per-node=1 \
./_run_locked.sh ./_setup.sh "$ENV_PATH" && \
    srun --output="slurm-%j.%t.experiment.out" ./_run_experiment.sh "$ENV_PATH" "$@" \
        --id $SLURM_ARRAY_TASK_ID
