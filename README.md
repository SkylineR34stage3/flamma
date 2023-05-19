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

# How to run rails command

This is how to run all rails commands (eg. `rails g scaffold books title:string`) in docker app

* Enter docker web container: `docker exec -it <name_of_your_web_container> bash`
  * Please replace `<name_of_your_web_container>` with actual name of your container
  * To check its name simply run `docker-compose ps` and get **NAME** (eg. _flamma-web-1_) from **web** **SERVICE**
* Go to application folder: `cd myapp/`
* Finally, You can run any rails command you want!
