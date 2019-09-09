#!/bin/bash

# bash script that runs papermill
# the arguments will arrive from the github actions

# these 2 exports are required to ensure python building- apprently there is a bug in ASCII encoding in python3 and this is the temporay fix
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
NOTEBOOK_PATHS="/code/notebooks/*"

mkdir -p /code/outputs/
papermill_argument=""

for notebook in ${NOTEBOOK_PATHS};
do
    echo "Processing ${notebook}"
    baseName=`basename ${notebook} .ipynb`
    paramFilename="/code/parameters/${baseName}"

    # Install dependencies from requirements file
    requirementsFileName="/code/requirements/${baseName}.txt"
    echo "requirements file located at: ${requirementsFileName}"

    if [[ -f "${requirementsFileName}" ]]; then
        echo "Installing dependencies from: ${requirementsFileName}"
        bash -c "pip3 install -r ${requirementsFileName}"
    else
        echo "No requirements file found for: ${notebook}"
    fi


    # now we need the contents of the params file in -p format
    while read line;
    do
        papermill_argument+=" -p ${line}"
    done < ${paramFilename}

    echo "papermillArgs: ${papermill_argument}"
    outputFileName="/code/outputs/output_${baseName}.ipynb"

    echo "papermill ${notebook} ${outputFileName} ${papermill_argument}"

    bash -c "papermill ${notebook} ${outputFileName} ${papermill_argument}"
done
#sleep infinity
