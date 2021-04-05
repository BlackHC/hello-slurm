#!/bin/bash
# You can also set environment variables to set options.
#SBATCH --cpus-per-task=4
#SBATCH --output="slurm-%j.batch.out"
#SBATCH --mail-type=END,FAIL

echo "SBATCH node: $(hostname)"

# exit when any command fails
set -e

# enable tracing
set -x

# REQUIRE CLOUD_TYPE environment variable
[ -z "$CLOUD_TYPE" ] && echo "CLOUD_TYPE not set!" && exit 1

SCRIPT_BASE="$(dirname -- "$0")"

# shellcheck source=arc/_sbatch_config.sh
# Set CONDA_ENVS_PATH
. ${SCRIPT_BASE}/${CLOUD_TYPE}/_sbatch_config.sh

# This is a configuration option for _setup.sh
export PYTHON_VERSION=3.8

export CURRENT_CONDA_ENV_PATH=${CONDA_ENVS_PATH}/job-$SLURM_JOB_ID

function cleanup() {
    ./_cleanup.sh "$CURRENT_CONDA_ENV_PATH"
}
trap cleanup EXIT

# for $SLURM_ARRAY_TASK_ID
ARGS=("${@//%SLURM_ARRAY_TASK_ID/$SLURM_ARRAY_TASK_ID}")


# Only one task/node when running with job arrays.
#srun --output="slurm-%j.%t.setup.out" --ntasks-per-node=1 \
./_run_locked.sh ./_setup.sh && \
    srun --output="slurm-%j.%t.experiment.out" ./_run_experiment.sh "${ARGS[@]}"