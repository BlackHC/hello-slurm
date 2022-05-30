#!/bin/bash
# _setup.sh
# EXPECTS:
# - SLURM_SCRIPT_INCLUDE
# - CURRENT_CONDA_ENV_PATH
# - CLOUD_TYPE
# - PYTHON_VERSION
# - TMPDIR

echo "Node $(hostname)"

# Exit when any command fails
set -e

# Uncomment to enable tracing
set -x

# shellcheck source=./arc/_setup_config.sh
. "${SLURM_SCRIPT_INCLUDE}/${CLOUD_TYPE}/_setup_config.sh"

export BUILD_DIR=$TMPDIR/pip-build

conda config --add channels conda-forge
conda config --set channel_priority flexible

conda create -q -y -p "${CURRENT_CONDA_ENV_PATH}" "python=${PYTHON_VERSION}"
source activate "${CURRENT_CONDA_ENV_PATH}"

: "${CONDA_ENV_FILE:=slurm-conda.yml}"
: "${MANUAL_SETUP:=_setup.sh}"

if test -f "${MANUAL_SETUP}"; then
  "${MANUAL_SETUP}"
elif test -f "${CONDA_ENV_FILE}"; then
  conda env update -y --file "${CONDA_ENV_FILE}"
else
  #conda install -y pytorch=1.8.1 "torchvision>=0.8.1" cudatoolkit=10.2 ignite -c pytorch
  conda install -y pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch-lts
  conda install ignite -c pytorch
fi

if test  -f "setup.py"; then
  pip install -e .
fi

# nvidia-smi || true
