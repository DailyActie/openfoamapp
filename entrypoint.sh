#!/bin/bash

# set right environment
source /opt/openfoam5/etc/bashrc

# make run file editable
OPENFOAM_RUN_FILE=${OPENFOAM_RUN_FILE:-"./run.sh"}
FOAM_RUN=/home/openfoam/run

# backup input files
mkdir -p $FOAM_RUN
cp -pr /input/* $FOAM_RUN

# use the right run script
cd $FOAM_RUN
openfoam_script="$(pwd)/$OPENFOAM_RUN_FILE"
if [ ! -f $openfoam_script ]
then
	echo "The specified run file '$openfoam_script' does not exist."
	exit 1
fi

# start simulation
chmod +x $openfoam_script
$openfoam_script "$@"

# copy all input files and results to output folder
cp -pr $FOAM_RUN/* /output
# restore input files
rm -rf $FOAM_RUN/*
