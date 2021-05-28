#!/bin/bash

if [ -z "$environment" ]
then
  . ./.init.getenv.sh
fi

is_sudoer=`groups "$(id -un)" | grep -q ' sudo ' && echo 1 || echo 0`
user_id=`id -u`


if [ "$user_id" = 0 ]
then
  #root
  . ./.init.root.sh
else
  if [ "$is_sudoer" = 1 ]
  then
    answers=("y" "n")
    while true
    do
      read -p "You are in sudo group. Would you like to execute privileged part through sudo? [y]: " run
      if [ -z "$run" ]
      then
        run="y"
      fi
      # lowercase
      run=$(echo $run | tr '[:upper:]' '[:lower:]')
      # in array of possible envs
      for answer_variant in ${answers[@]}
      do
        if [ "$run" = "$answer_variant" ]
        then
          break 2
        fi
      done
      echo "Invalid answer \"$run\" specified! Should be one of [${answers[@]}]."
    done
    if [ "$run" = 'y' ]
    then
      sudo ./.init.sudoer.sh $environment $(whoami)
    fi
  fi
  . ./.init.user.sh
fi

echo "FINISHED."