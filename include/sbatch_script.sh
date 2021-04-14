#!/bin/bash
# You can also set environment variables to set options.
#SBATCH --cpus-per-task=4
#SBATCH --output="slurm-%j.setup.%A_%a.%N.out"
#SBATCH --mail-type=END,FAIL

# EXCEPTS SLURM_SCRIPT_INCLUDE
# EXCEPTS CLOUD_TYPE

[ -z "$SLURM_SCRIPT_INCLUDE" ] && echo "SLURM_SCRIPT_INCLUDE not set!" && exit 1
[ -z "$CLOUD_TYPE" ] && echo "CLOUD_TYPE not set!" && exit 1

echo "SBATCH node: $(hostname)"

# exit when any command fails
set -e

# enable tracing
set -x

# shellcheck source=arc/_sbatch_config.sh
# Set CONDA_ENVS_PATH
. "${SLURM_SCRIPT_INCLUDE}/${CLOUD_TYPE}/_sbatch_config.sh"

# This is a configuration option for _setup.sh
export PYTHON_VERSION=3.8

export CURRENT_CONDA_ENV_PATH="${CONDA_ENVS_PATH}/job-$SLURM_JOB_ID"

function cleanup() {
    "${SLURM_SCRIPT_INCLUDE}/_cleanup.sh" "$CURRENT_CONDA_ENV_PATH"
}
trap cleanup EXIT

# for $SLURM_ARRAY_TASK_ID
ARGS=("${@//%SLURM_ARRAY_TASK_ID/$SLURM_ARRAY_TASK_ID}")

# Only one task/node when running with job arrays.
#srun --output="slurm-%j.%t.setup.out" --ntasks-per-node=1 \
"${SLURM_SCRIPT_INCLUDE}/_run_locked.sh" "${SLURM_SCRIPT_INCLUDE}/_setup.sh" && \
    ("${SLURM_SCRIPT_INCLUDE}/_run_experiment.sh" "${ARGS[@]}" > "slurm-%j.experiment.%A_%a.%N.out" 2>&1)

    