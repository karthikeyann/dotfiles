#!/bin/bash
[[ -z "$CONDA_PREFIX" ]] && { echo "\$CONDA_PREFIX is empty. Activate a conda env" ; exit 1; }
echo -e "enabling cudf build without installing at conda root $CONDA_PREFIX"
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
mkdir -p $CONDA_PREFIX/etc/conda/deactivate.d
cp activate.d/env-vars.sh $CONDA_PREFIX/etc/conda/activate.d/env-vars.sh
cp deactivate.d/env-vars.sh $CONDA_PREFIX/etc/conda/deactivate.d/env-vars.sh
