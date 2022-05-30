#!/bin/bash

export PATH="/scratch-ssd/oatml/miniconda3/bin:$PATH"

export LOCAL_SCRATCH=/scratch-ssd/$USER
export CONDA_PKGS_DIRS=$LOCAL_SCRATCH/conda_pkgs_cache

export TMPDIR=/scratch-ssd/$USER/tmp
mkdir -p $TMPDIR

export WANDB_CACHE_DIR=$TMPDIR/wandb-cache
mkdir -p $WANDB_CACHE_DIR

export CONDA_ENVS_PATH=$TMPDIR/conda_envs

export FASTAI_HOME=$LOCAL_SCRATCH/.fastai
