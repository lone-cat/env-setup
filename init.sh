#!/bin/bash

ENVS=("prod" "dev" "stage")

fill_environment_variable(){
  local default_env=$(echo $ENV)
  if [ -z "$default_env" ]
  then
    default_env="prod"
  fi

  environment=""
  while true
  do
    read -p "Specify environment [$default_env]: " environment
    # default prod
    if [ -z "$environment" ]
    then
      environment="$default_env"
    fi
    # lowercase
    environment=$(echo $environment | tr '[:upper:]' '[:lower:]')
    # in array of possible envs
    for goodenv in ${ENVS[@]}
    do
      if [ "$environment" == "$goodenv" ]
      then
        return
      fi
    done
    echo "Invalid environment \"$environment\" specified! Should be one of [${ENVS[@]}]."
  done
}

fill_environment_variable

default_user=$(whoami)

echo ""
echo "PREPARING WORKSPACE FOR ENVIRONMENT \"$environment\"..."

#is_sudoer=`groups "$(id -un)" | grep -q ' sudo ' && echo 1 || echo 0`
user_id=`id -u`


if [[ $user_id == 0 ]]
then
  . ./root_commands.sh
else
  . ./user_commands.sh
fi

echo "FINISHED."