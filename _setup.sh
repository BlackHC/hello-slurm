#!/bin/bash
# _setup.sh /scratch-ssd/$USER/conda_envs/hello-slurm

echo "Node $(hostname)"

# Exit when any command fails
set -e

# Uncomment to enable tracing
set -x

ENV_PATH="$1"

./mount_scratch.sh || (echo "Failed to mount gigi's scratch directory!" && false)

mkdir -p $TMPDIR
export BUILD_DIR=/scratch-ssd/${USER}/conda_envs/pip-build

conda config --add channels conda-forge
conda config --set channel_priority flexible

conda create -q -y -p "$ENV_PATH" python=${PYTHON_VERSION}
source activate "$ENV_PATH"

# Install conda and pip packages now.
conda install -y -q pip
conda install -y pytorch=1.7 torchvision cudatoolkit=11 ignite -c pytorch

pip install -r requirements.txt

# nvidia-smi || true
