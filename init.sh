#!/bin/bash

# Create necessary folders
mkdir -p certbot-storage
mkdir -p telegraf-storage
mkdir -p telegraf-storage/telegraf.conf
mkdir -p mosquitto-storage/config
mkdir -p mosquitto-storage/config/cert
mkdir -p mosquitto-storage/log
mkdir -p mosquitto-storage/data
mkdir -p nodered-storage
mkdir -p influxdb-storage
mkdir -p grafana-storage
mkdir -p grafana-provisioning
mkdir -p grafana-dashboards

# Create empty files
touch mosquitto-storage/config/passwordfile

# Set permissions
sudo chown -R 1000:1001 certbot-storage telegraf-storage mosquitto-storage nodered-storage influxdb-storage grafana-storage
sudo chmod -R 755 certbot-storage telegraf-storage mosquitto-storage nodered-storage influxdb-storage grafana-storage
sudo chmod -R 777 mosquitto-storage/data mosquitto-storage/log


cmd="./reloadCert.sh"

# Start the certbot service and wait for it to exit
docker-compose up --detach certbot
docker wait $(docker-compose ps -q certbot)

# Start the other services if the certbot service exited with a success code
if [ $? -eq 0 ]; then
  docker-compose up -d 
fi

# Check if the cronjob already exists
existing_cron=$(crontab -l | grep "$cmd")
if [ -n "$existing_cron" ]; then
    echo "Cronjob already exists"
    exit 1
fi

# Add the cronjob to the crontab file
(crontab -l 2>/dev/null; echo "0 0 1 * * $cmd") | crontab -

echo "Cronjob added successfully"