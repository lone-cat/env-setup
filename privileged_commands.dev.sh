#!/bin/bash

environment=dev

echo ""
echo "BEGIN EXECUTION OF PRIVILEGED PART..."
# install ifconfig
apt install net-tools

global=true
. ./set_env_vars.sh

echo "FINISHED EXECUTION OF PRIVILEGED PART."
echo ""