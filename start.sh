#!/bin/bash

export PATH=$CONDA_DIR/bin:$PATH
export PYTHONPATH=$SPARK_HOME/python:$(echo $SPARK_HOME/python/lib/py4j-*-src.zip)

if [[ "x$JUPYTER_NOTEBOOK_PASSWORD" != "x" ]]; then
    HASH=$(python -c "from notebook.auth import passwd; print(passwd('$JUPYTER_NOTEBOOK_PASSWORD'))")
    echo "c.NotebookApp.password = u'$HASH'" >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py
fi

if [[ -n "$JUPYTER_NOTEBOOK_X_INCLUDE" ]]; then
    curl -O $JUPYTER_NOTEBOOK_X_INCLUDE
fi

exec jupyter notebook
