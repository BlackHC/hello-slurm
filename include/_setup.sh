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

: "${CONDA_TXT_FILE:=slurm-conda.txt}"
: "${CONDA_ENV_FILE:=slurm-conda.yml}"
: "${MANUAL_SETUP:=_setup.sh}"

if test -f "${MANUAL_SETUP}"; then
  "${MANUAL_SETUP}"
elif test -f "${CONDA_TXT_FILE}"; then
  conda update -y --file "${CONDA_TXT_FILE}"
elif test -f "${CONDA_ENV_FILE}"; then
  conda env update -y --file "${CONDA_ENV_FILE}"
else
  conda install pytorch torchvision torchaudio pytorch-cuda=11.6 -c pytorch -c nvidia
fi

if test -f "setup.py"; then
  pip install -e .
elif test -f "requirements.txt"; then
  pip install -r requirements.txt
fi

nvidia-smi || true
