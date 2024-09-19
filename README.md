# Dockerized version of VoyantServer

## Setup

1) Clone this repository: `git clone https://github.com/voyanttools/docker.git`

2) Run the Docker compose command from the repository's directory on your computer: `LOCAL_VOLUME=/VoyantData LOCAL_MEMORY=4 docker compose up local -d`

   * Replace the `LOCAL_VOLUME` value with the path to the directory you want to use for storing Voyant data.
   * Replace the `LOCAL_MEMORY` value with number of gigabytes of RAM you want to make available to Voyant.

3) Open Voyant in your browser: http://localhost:8080

## Other

### Cron Jobs

See the `helper_scripts` folder for scripts that could be added to the system (outside of Docker).
