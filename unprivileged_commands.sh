#!/bin/bash

echo ""
echo "BEGIN EXECUTION OF UNPRIVILEGED PART..."

if [ -n "$1" ]
then
  ENV=$1
else
  echo "Environment not specified! Exiting."
  exit
fi

# disable convert lf to crlf when cloning repositories
git config --global core.autocrlf input

# add env vars for docker-compose
IFS=$'\n'
file="./env.$ENV"
bash_login="$HOME/.bash_login"

bash_updated=0

if ! [ -f $bash_login ]
then
  touch $bash_login
  echo "created file $bash_login"
fi

for var in $(cat $file)
do
  varname=`echo $var | cut -f1 -d=`
  varvalue=`echo $var | cut -f2- -d=`

  exists=`sed -n '/^export '$varname'=.*$/p' $bash_login`

  if [[ $exists != "" ]]
  then
    if [[ $exists != "export $var" ]]
    then
      sed -i 's/^'$exists'$/# '$exists'/i' $bash_login
      echo "export $var" >> $bash_login
      echo "replaced $varname"
      (( bash_updated++ ))
    fi
  else
    echo "export $var" >> $bash_login
    echo "inserted $varname"
    (( bash_updated++ ))
  fi

done

if [[ $bash_updated > 0 ]]
then
  echo "run '. ~/.bash_login' command or restart bash now."
fi

echo "FINISHED EXECUTION OF UNPRIVILEGED PART."
echo ""