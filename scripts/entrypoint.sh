#!/usr/bin/env bash

# bash script that runs papermill
# the arguments will arrive from the github actions

NOTEBOOK_PATHS="/code/notebooks/"
#PAPERMILL_ARGUMENTS_FOLDER="/code/parameters/"

for notebook in ${NOTEBOOK_PATHS};
do
    echo "Processing ${notebook}"
    baseName=`basename ${notebook} .ipynb`
    param="/code/parameters/${baseName}"

    # now we need the contents of the params file in -p format



done


