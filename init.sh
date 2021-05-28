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


run_priviledged_block(){
  if [ $1 -eq 1 ]
  then
    local sudo="sudo "
  else
    local sudo=""
  fi
  #echo "$sudo./privileged_commands.$environment.sh"
  bash -c "$sudo./privileged_commands.sh $environment $(whoami)"
}

fill_environment_variable

echo ""
echo "PREPARING WORKSPACE FOR ENVIRONMENT \"$environment\"..."

is_sudoer=`groups "$(id -un)" | grep -q ' sudo ' && echo 1 || echo 0`
user_id=`id -u`

if [[ $user_id == 0 ]]
then
  run_priviledged_block 0
  echo "Now you should run this script as unprivileged user"
else
  if [[ $is_sudoer == 1 ]]
  then
    run_priviledged_block 1
  else
    echo "You have not enough privileges. Run script as user with sudo privileges or root!"
  fi

  . ./unprivileged_commands.sh
fi

echo "FINISHED."