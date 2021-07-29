#!/bin/bash

# Load anaconda and python
module load Anaconda3/2020.11
module load CUDA/11.1.1-GCC-10.2.0

# $SCRATCH is on a shared file system and available to all nodes in a job, if a job spans multiple nodes.
# $TMPDIR is local to a compute node
# $DATA (/data/projectname/username)  sharing a 5TB quota with your project colleagues

# Cache packages locally
# NOTE: conda race condition means we cannot use a single package cache reliably
#export CONDA_PKGS_DIRS=$DATA/conda_pkgs_cache
# TODO: switch to mamba as soon as they push a release with the new lockfile code.
# See https://github.com/mamba-org/mamba/issues/739
export CONDA_PKGS_DIRS=$TMPDIR/conda_pkgs_cache

# Store conda envs locally
export CONDA_ENVS_PATH=$TMPDIR/conda_envs

export FASTAI_HOME=$DATA/.fastai

