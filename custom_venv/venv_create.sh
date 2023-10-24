#!/bin/bash

#---------------------------------------------------#
#       NOTE 1: NOT A SLURM SCRIPT
#       Note 2: Run this routine on the login node,
#               with internet access
#---------------------------------------------------#

# Sets the parameters for the virtualenv creation
VIRTUALENV_BASE_FOLDER=/home/lourenco/projects/rrg-ggalex/lourenco/python_venvs/
NEW_VIRTUALENV_NAME=xinran_pcmci_2023-10-23

# Force environment cleanup
module --force purge

# Load the python module in which you want the environment to be used
module load StdEnv/2020 gcc/9.3.0 gdal/3.5.1 python/3.10.2

# Create base virtualenv
COMBINEDPATH="$VIRTUALENV_BASE_FOLDER$NEW_VIRTUALENV_NAME"
virtualenv $COMBINEDPATH

# Activate environment for further package install
ACTIVATEENV="$COMBINEDPATH/bin/activate"
source ACTIVATEENV

# Upgrade pip (as it is using AllianceCan binaries, and may be old)
pip install --upgrade pip

# Install python libraries from list
pip install -r ./requirements.txt

# Deactivate environment
deactivate

# End message
echo "End run. Created the following virtualenv: "
echo $COMBINEDPATH
echo "Please test the new  environment before using."
