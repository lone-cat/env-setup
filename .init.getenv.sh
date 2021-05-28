#!/bin/bash

envs=("prod" "dev" "stage")

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
    for goodenv in ${envs[@]}
    do
      if [ "$environment" == "$goodenv" ]
      then
        return
      fi
    done
    echo "Invalid environment \"$environment\" specified! Should be one of [${envs[@]}]."
  done
}

fill_environment_variable