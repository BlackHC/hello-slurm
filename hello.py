from dataclasses import dataclass

import torch
import os

import typing


def _int_or_none(v: typing.Optional[str]):
    if v:
        return int(v)
    return None


@dataclass
class SlurmInfo:
    """
    Selection of the possibly set environment variables:
    """

    job_id: int
    job_name: str
    array_job_value: typing.Optional[int]
    # array_task_idx is a misleading name because it not connected to the job/step/task context
    array_job_idx: typing.Optional[int]

    cluster_name: str
    cpus_per_task: typing.Optional[int]
    gpus_per_task: typing.Optional[int]

    job_num_nodes: int
    job_partition: str
    job_uid: int
    job_user: str

    step_idx: int
    # SLURM_PROCID
    task_idx: int
    num_tasks: int
    # num_tasks_per_node: int

    node_idx: int
    node_name: str

    # for the step
    num_nodes: int    

    debug: int
    
    @staticmethod
    def from_environ():
        return SlurmInfo(
            job_id=os.environ["SLURM_JOB_ID"],
            job_name=os.environ["SLURM_JOB_NAME"],
            array_job_value=_int_or_none(os.environ.get("SLURM_ARRAY_JOB_ID")),
            array_job_idx=_int_or_none(os.environ.get("SLURM_ARRAY_TASK_ID")),
            cluster_name=os.environ["SLURM_CLUSTER_NAME"],
            cpus_per_task=_int_or_none(os.environ.get("SLURM_CPUS_PER_TASK")),
            gpus_per_task=_int_or_none(os.environ.get("SLURM_GPUS_PER_TASK")),
            job_num_nodes=int(os.environ["SLURM_JOB_NUM_NODES"]),
            job_partition=os.environ["SLURM_JOB_PARTITION"],
            job_uid=int(os.environ["SLURM_JOB_UID"]),
            job_user=os.environ["SLURM_JOB_USER"],
            step_idx=int(os.environ["SLURM_STEP_ID"]),
            task_idx=int(os.environ["SLURM_PROCID"]),
            num_tasks=int(os.environ["SLURM_STEP_NUM_TASKS"]),
            # num_tasks_per_node=int(os.environ["SLURM_STEP_TASKS_PER_NODE"]),
            num_nodes=int(os.environ["SLURM_STEP_NUM_NODES"]),
            debug=int(os.environ["SRUN_DEBUG"]),
            node_name=os.environ["SLURMD_NODENAME"],
            node_idx=int(os.environ["SLURM_NODEID"]),
        )


slurm_info = None

if os.environ.get("SLURM_JOB_ID"):
    slurm_info = SlurmInfo.from_environ()

print("Hello Slurm!")
print(slurm_info)
