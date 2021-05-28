#!/bin/bash

echo ""
echo "BEGIN ENVIRONMENT SETUP..."

if [ -z "$environment" ]
then
  echo "environment not specified! exiting."
  exit
fi

env_file="/etc/profile.d/alex-env.sh"

# add env vars for docker-compose
old_ifs=$IFS
IFS=$'\n'
source_file="./env.$environment"


env_file_updated=0

if ! [ -f $env_file ]
then
  touch $env_file
  echo "created file $env_file"
fi

for var in $(cat $source_file)
do
  varname=`echo $var | cut -f1 -d=`
  varvalue=`echo $var | cut -f2- -d=`

  exists=`sed -n '/^export '$varname'=.*$/p' $env_file`

  if [[ $exists != "" ]]
  then
    if [[ $exists != "export $var" ]]
    then
      sed -i 's/^'$exists'$/# '$exists'/i' $env_file
      echo "export $var" >> $env_file
      echo "replaced $varname"
      (( env_file_updated++ ))
    fi
  else
    echo "export $var" >> $env_file
    echo "inserted $varname"
    (( env_file_updated++ ))
  fi

done

if [[ $env_file_updated > 0 ]]
then
  echo "environment updated."
fi

echo "FINISHED ENVIRONMENT SETUP."
echo ""

IFS=$old_ifs