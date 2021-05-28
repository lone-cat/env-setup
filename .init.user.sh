#!/bin/bash

if [ -z "$environment" ]
then
  . ./.init.getenv.sh
fi

default_user=$(whoami)

echo ""
echo "PREPARING WORKSPACE FOR ENVIRONMENT \"$environment\"..."

. ./.user_commands.sh

echo "FINISHED."