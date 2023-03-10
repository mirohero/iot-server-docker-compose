# IoT Home automation system with Docker Compose

This repository provides a pre-configured Docker Compose setup for setting up a comprehensive home or building server with a range of essential services. The server stack includes Certbot for secure HTTPS connections, MQTT for efficient messaging, InfluxDB for time-series data storage, Telegraf for collecting system metrics, Node-RED for visual programming, and Grafana for data visualization. The Docker-based deployment simplifies the process of managing and scaling these services, making it easy to build a versatile server for home automation, IoT monitoring, or other applications. With this pre-configured Docker setup, users can easily deploy and manage their own comprehensive server stack with minimal effort.

1. Clone the repository onto your machine. 
2. Add environment variables to your `.env` file. Specifically, you need to set the `EMAIL` and `DOMAIN` variables, as well as the `MOSQUITTO_USERNAME`, `MOSQUITTO_PASSWORD`, `INFLUXDB_USERNAME`, `INFLUXDB_PASSWORD`, `GRAFANA_USERNAME`, and `GRAFANA_PASSWORD` variables.
3. Change the image tag `:arm64v8-latest` in the `docker-compose.yml` file depending on your instance.
4. Run the `init.sh` script. This will create necessary folders and set the appropriate permissions.


The Certbot service will automatically manage SSL certificates for you. A cronjob is added to the system that will reload the certificates once a month.

## Scripts and files

### `init.sh`
The `init.sh` script creates the necessary folders for the automation system to run. It sets the appropriate permissions for the folders and creates empty files. It also starts the Certbot service and waits for it to exit. If the Certbot service exits with a success code, it starts the other services.

### `reloadCert.sh`
The `reloadCert.sh` script reloads the SSL certificates for the Mosquitto and InfluxDB services. It starts the Certbot service and waits for it to exit. If the Certbot service exits with a success code, it restarts the Mosquitto and InfluxDB services.

### `docker-compose.yml`
The `docker-compose.yml` file defines the services that make up the automation system. It includes the following services:

- Certbot: Automates the SSL certificate management process using Let's Encrypt.
- Telegraf: A plugin-driven server agent for collecting and reporting metrics.
- Mosquitto: An open source MQTT broker.
- Node-RED: A programming tool for wiring together hardware devices, APIs, and online services.
- InfluxDB: A high-performance, distributed, and scalable time-series database.
- Grafana: An open source analytics and monitoring platform.

The Docker Compose file specifies the dependencies between the services and sets the necessary volumes and ports. Note that you must change the image tag `:arm64v8-latest` in the file depending on your instance.
