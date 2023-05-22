#!/bin/bash
# _run_experiment.sh ...
# EXPECTS CURRENT_CONDA_ENV_PATH

echo "Node $(hostname)"

# Exit when any command fails
set -e

# Uncomment to enable tracing
set -x

source activate "$CURRENT_CONDA_ENV_PATH"

# Check whether command type is python or bash and execute accordingly
if [ "$COMMAND_TYPE" = "python" ]; then
  python "${@}"
elif [ "$COMMAND_TYPE" = "bash" ]; then
  "${@}"
else
  echo "Unknown command type: $COMMAND_TYPE"
  exit 1
fi

