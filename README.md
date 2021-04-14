# SLURM wrappers for OATCLOUD and ARC

Comes as is, and the scripts will likely evolve and remain as opinionated as possible for me to get stuff done quickly.

The shell scripts here provide a thin wrapper around sbatch to execute Python scripts on both OATCLOUD and ARC with minimal changes. OATCLOUD is [OATML](https://oatml.cs.ox.ac.uk/)'s internal cloud, and [ARC](https://www.arc.ox.ac.uk/) is a compute cluster of the University of Oxford.

## Example

```bsbatch --array 900 --job-name hello --time=01:30:00 -- example/hello.py```


## Setup

1. `git clone git@github.com:BlackHC/hello-slurm.git`
1. Add `hello-slurm/bin` to your PATH on both OATCLOUD and ARC. 
1. Set environment variables on both OATCLOUD and ARC:
    
    * `CLOUD_TYPE` to either `arc` or `oatml`.
    * `SLURM_MAIL` to your preferred email address to receive notifications (also works with Slack).

`SLURM_MAIL` is required at the moment. If you want to disable it, fork the repository and hack the scripts :tada:

## Scripts

* `bsbatch` wraps `sbatch` and:
  * uses the local `CLOUD_TYPE` and `SLURM_MAIL` to determine the environment and email to send notifcations to.
  * is meant for running with slurm job arrays.
  * supports `%SLURM_ARRAY_TASK_ID` in script arguments and turns it into `$SLURM_ARRAY_TASK_ID`.
  
   ```bsbatch [options] -- script_name.py [script arguments]```
  * supports `--gpu` or `--rtx` to request a single GPU as additional resource (generic or rtx).

   By default 4 CPUs, respectively 3 CPUS (for ARC), are requested, see `include/sbatch_script.sh`.

* `bexportconda` creates `slum-conda.yml` from the current environment, which `bsbatch` supports automatically.

