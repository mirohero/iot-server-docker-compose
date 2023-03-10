#!/bin/bash

# Start the certbot service and wait for it to exit
docker-compose up --detach certbot
docker wait $(docker-compose ps -q certbot)

# Start the other services if the certbot service exited with a success code
if [ $? -eq 0 ]; then
  docker restart mosquitto
  docker restart influxdb
fi