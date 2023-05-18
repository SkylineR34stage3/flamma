# Flamma installation guide

This is flamma installation guide using Docker Compose

* Install **docker-compose** on your system

* Check if it is installed successfully (type `docker-compose ps`)

* Run `docker-compose up --build`

* Enter docker container by running `docker exec -it flamma-web-1 bash`
  * Create db flamma: `bin/rails db:create`
  * Exit docker container: `exit`

* Rebuild docker containers: `docker-compose down && docker-compose up --build`

* Finally Go to http://0.0.0.0:3000
