# Dockerized version of VoyantServer

## Setup

1) Clone this repository: `git clone https://github.com/voyanttools/docker.git`

2) Run the Docker compose command from the repository's directory on your computer: `LOCALDIR=/VoyantData MEMORY=4 docker compose up local -d`

   * Replace the `LOCALDIR` value with the path to the directory you want to use for storing Voyant data.
   * Replace the `MEMORY` value with number of gigabytes of RAM you want to make available to Voyant.

3) Open Voyant in your browser: http://localhost:8080

## Other

### Cron Jobs

See the `helper_scripts` folder for scripts that could be added to the system (outside of Docker).

## Docker Desktop

When running from Docker Desktop, make sure to set the optional settings.

![image](https://github.com/user-attachments/assets/d22715c8-fcc8-4796-b700-f72a77d0d07d)
