#!/bin/bash

if [ -z "$environment" ]
then
  . ./.init.getenv.sh
fi

if [ -z "$default_user" ]
then
  default_user=$(whoami)
fi

if [ "$default_user" = "root" ]
then
  default_user="user"
fi

echo ""
echo "PREPARING WORKSPACE FOR ENVIRONMENT \"$environment\"..."

#is_sudoer=`groups "$(id -un)" | grep -q ' sudo ' && echo 1 || echo 0`
user_id=`id -u`


if [ "$user_id" = 0 ]
then
  . ./.root_commands.sh
else
  echo "Not enough privileges!"
fi

echo "FINISHED."