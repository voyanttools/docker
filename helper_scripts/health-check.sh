#!/bin/bash

# This script checks if a docker container is unhealthy and then restarts it and sends an email.
# Example cron entry:
# * * * * * /voyant-docker/helper_scripts/health-check.sh >> /dev/null 2>&1


UNHEALTHY=$(docker ps -q -f health=unhealthy)

if [[ -n $UNHEALTHY ]]
then
  echo $UNHEALTHY | xargs docker restart
  printf "Subject:Voyant Tools Server\n\nServer is restarting" | sudo ssmtp -F"Voyant Tools" voyanttools@gmail.com
fi
