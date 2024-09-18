#!/bin/bash

# this script checks if a docker container is unhealthy and then restarts it and sends an email

UNHEALTHY=$(docker ps -q -f health=unhealthy)

if [[ -n $UNHEALTHY ]]
then
  echo "restarting"
  echo $UNHEALTHY | xargs docker restart
  printf "Subject:Voyant Tools Server\n\nServer is restarting" | sudo ssmtp -F"Voyant Tools" voyanttools@gmail.com
else
  echo "not restarting"
fi
