# SLURM wrappers for OATCLOUD and ARC

Comes as is.

## Requirements

Set environment variables:

* `CLOUD_TYPE` to either `arc` or `oatml`.
* 'SLURM_MAIL' to your preferred email address to receive notifications (or e.g. a slack integration)

## Helpers

`bsbatch` wraps `sbatch` and uses the local `CLOUD_TYPE` and `SLURM_MAIL` to create an sbatch array

`bexportconda` creates `slum-conda.yml` from the current environment

## `bsbatch`

Supports `--any_gpu` to request a single GPU as additioanl resource.
By default 4 CPUs are requested.
