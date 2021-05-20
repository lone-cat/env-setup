#!/bin/bash

ENVS=("prod" "dev" "stage")

fill_environment_variable(){
  ENV=""
  while true
  do
    read -p "Specify environment [prod]: " ENV
    # default prod
    if [ ! -n "$ENV" ]
    then
      ENV="prod"
    fi
    # lowercase
    ENV=$(echo $ENV | tr '[:upper:]' '[:lower:]')
    # in array of possible envs
    for goodenv in ${ENVS[@]}
    do
      if [ "$ENV" == "$goodenv" ]
      then
        return
      fi
    done
    echo "Invalid environment \"$ENV\" specified! Should be one of [${ENVS[@]}]."
  done
}


run_priviledged_block(){
  if [ $1 -eq 1 ]
  then
    local sudo="sudo "
  else
    local sudo=""
  fi
  #echo "$sudo./privileged_commands.$ENV.sh"
  bash -c "$sudo./privileged_commands.$ENV.sh $(whoami)"
}

fill_environment_variable

echo ""
echo "PREPARING WORKSPACE FOR ENVIRONMENT \"$ENV\"..."

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
  bash -c "./unprivileged_commands.sh $ENV"
fi

echo "FINISHED."