# Dockerized version of VoyantServer

## Setup

### Cron Jobs

Scripts that should be added to the system (outside of Docker).

Check every minute and restart Docker when it becomes unresponsive:

`* * * * * docker ps -q -f health=unhealthy | xargs docker restart >/dev/null 2>&1`
