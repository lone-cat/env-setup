#!/bin/bash

echo ""
echo "BEGIN EXECUTION OF UNPRIVILEGED PART..."

# disable convert lf to crlf when cloning repositories
git config --global core.autocrlf input

echo "FINISHED EXECUTION OF UNPRIVILEGED PART."
echo ""