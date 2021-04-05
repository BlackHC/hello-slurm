#!/bin/bash

# Load anaconda and python
module load python/anaconda3/2020.02

# $SCRATCH is on a shared file system and available to all nodes in a job, if a job spans multiple nodes.
# $TMPDIR is local to a compute node
# $DATA (/data/projectname/username)  sharing a 5TB quota with your project colleagues

# Cache packages globally
export CONDA_PKGS_DIRS=$DATA/conda_pkgs_cache
# Store conda envs locally
export CONDA_ENVS_PATH=$TMPDIR/conda_envs

export FASTAI_HOME=$DATA/.fastai