#!/bin/bash

echo ""
echo "BEGIN EXECUTION OF PRIVILEGED PART..."

environment=$1
shift

. ./root_commands.$environment.sh
. ./set_env_vars.sh

echo "FINISHED EXECUTION OF PRIVILEGED PART."
echo ""