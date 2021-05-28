#!/bin/bash

echo ""
echo "BEGIN EXECUTION OF PRIVILEGED PART..."

environment=$1
shift

. ./privileged_commands.$environment.sh

echo "FINISHED EXECUTION OF PRIVILEGED PART."
echo ""