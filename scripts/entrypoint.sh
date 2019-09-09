#!/bin/bash

# bash script that runs papermill
# the arguments will arrive from the github actions
export LC_ALL="en_US.utf-8"
export LANG="en_US.utf-8"
NOTEBOOK_PATHS="/code/notebooks/*"

mkdir -p /code/outputs/
papermill_argument=""

for notebook in ${NOTEBOOK_PATHS};
do
    echo "Processing ${notebook}"
    baseName=`basename ${notebook} .ipynb`
    paramFilename="/code/parameters/${baseName}"

    # now we need the contents of the params file in -p format
    while read line;
    do
        papermill_argument+=" -p ${line}"
    done < ${paramFilename}

    echo "papermillArgs: ${papermill_argument}"
    outputFileName="/code/outputs/output_${baseName}.ipynb"

    echo "papermill ${notebook} ${outputFileName} ${papermill_argument}"

    papermill "${notebook}" "${outputFileName} ${papermill_argument}"
done

sleep infinity
