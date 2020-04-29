#!/bin/bash
#eg setup.sh /scratch-ssd/$USER/conda_envs/hello-slurm
ENV_PATH="$1"

export PATH="/scratch-ssd/oatml/miniconda3/bin:$PATH"

export CONDA_PKGS_DIRS=/scratch-ssd/$USER/conda_pkgs
export TMPDIR=/scratch/${USER}/tmp
mkdir -p $TMPDIR
BUILD_DIR=/scratch-ssd/${USER}/conda_envs/pip-build

conda config --add channels conda-forge 
conda config --set channel_priority strict

conda create -p "$ENV_PATH" python=3.8
conda activate "$ENV_PATH"

# Install conda and pip packages now.
conda install pytorch torchvision cudatoolkit=10.2 -c pytorch
