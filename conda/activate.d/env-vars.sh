#!/bin/sh
#[[ "${TERM_PROGRAM}" == "vscode" ]] && export CUDF_HOME=`pwd`

CUDF_HOME=${CUDF_HOME:-$HOME/cudf}
echo "CUDF_HOME: $CUDF_HOME"
export CUDF_HOME=$CUDF_HOME
CUDF_CPP_HOME=$CUDF_HOME/cpp/build
CUDF_PYTHON_HOME=$CUDF_HOME/python
export NVSTRINGS_ROOT=$CUDF_HOME/cpp/build
export OLD_PYTHONPATH=$PYTHONPATH
export OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH:$CUDF_PYTHON_HOME/cudf:$CUDF_PYTHON_HOME/nvstrings:$CUDF_PYTHON_HOME/nvstrings/build:$CUDF_PYTHON_HOME/dask_cudf
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDF_CPP_HOME:$CUDF_CPP_HOME/release
source /home/karthikeyan/dev/rapids/compose/etc/bash-utils.sh
