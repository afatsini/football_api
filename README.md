# FootballApi
A simple Elixir application that serves the football results included in a data.csv file.

# Installation

## Prerequisites

- docker >=  1.13.0
- elixir 1.7.1
- erlang 21.0.1

## Run single instance

```bash
docker build . --tag football-api #build
docker run -p4000:4000 football-api #run server
```

The project will be accessible via: `http://127.0.0.1:4000/`

you should see the status page: '{"ping": "pong"}'

## Run in HA

To run the project in HA mode, run the commands:

```bash
docker swarm init #set swarm mode
docker stack deploy --compose-file=docker-compose.yml prod #deploy
```

The project will be accessible via: `http://127.0.0.1:80/`

The images are stored in dockerhub (no local builds).

We can check the status of the deployed containers: `docker service ls`.

It should contain 1 HA-proxy instance + 3 intance of the football-api.

### Release of new API version
A new version can be deployed with the `docker service update`.
The image also needs to be available on dockerhub.
I build a test image to check this feature:

`docker service update --image afatsini/football-api:v2 prod_football-api`

After the deploy the `http://127.0.0.1:80/` should print:

`{"ping":"pong2"}`

### Add more instances
To add more instances to the swarm we can do it with the command:

`docker service scale prod_football-api=5`

With this command we increase the football-api instance to 5.

We can check it running the `docker service ls`.
That should print that we are running 5 replicas.

### More settings
All the swarm settings can be edited via docker-compose.yml file.

## Technology used
The HA setting is build using the docker swarm and the dockercloud-haproxy image.
The image expects the env var SERVICE_PORTS to be set in the dockerfile with the
exposed ports.

### references
- https://docs.docker.com/compose/compose-file/
- https://docs.docker.com/engine/swarm/stack-deploy/
- https://hub.docker.com/r/dockercloud/haproxy/
- https://docs.docker.com/network/network-tutorial-overlay/



