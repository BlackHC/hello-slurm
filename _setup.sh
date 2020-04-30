#!/bin/bash
#eg setup.sh /scratch-ssd/$USER/conda_envs/hello-slurm

# Uncomment to enable tracing
#set -x

echo "SETUP node $(hostname)"

ENV_PATH="$1"

mkdir -p $TMPDIR
export BUILD_DIR=/scratch-ssd/${USER}/conda_envs/pip-build

conda config --add channels conda-forge 
conda config --set channel_priority strict

conda create -q -y -p "$ENV_PATH" python=3.8
source activate "$ENV_PATH"

# Install conda and pip packages now.
conda install -q -y pytorch torchvision cudatoolkit=10.2 -c pytorch

nvidia-smi
