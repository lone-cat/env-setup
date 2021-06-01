#!/bin/bash

echo ""
echo "BEGIN EXECUTION OF PRIVILEGED PART..."

git config --system core.autocrlf input

. ./.root_commands.$environment.sh
. ./.set_env_vars.sh

echo "FINISHED EXECUTION OF PRIVILEGED PART."
echo ""