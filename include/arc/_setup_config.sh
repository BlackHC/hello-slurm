#!/bin/bash

# conda tries to delete empty parent directories---but obviously fails at /tmp/
touch $TMPDIR/not_empty

