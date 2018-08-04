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

### Technology used
The HA setting is build using the docker swarm and the dockercloud-haproxy image.
The image expects the env var SERVICE_PORTS to be set in the dockerfile with the
exposed ports.

### references
- https://docs.docker.com/compose/compose-file/
- https://docs.docker.com/engine/swarm/stack-deploy/
- https://hub.docker.com/r/dockercloud/haproxy/
- https://docs.docker.com/network/network-tutorial-overlay/

## Test
To ensure that the project is properly working, you can run the test suit:

`mix test`

## API reference
The API reference can be found in the `Postman Collections` folder,
generated with Postman.
It includes a swagger definition in the `swagger.yml`.

It also contains a Postman test suite `Football_api.json` that can be 
imported to Postman and make live requests to the api.
To run it, you also need to import the environment file `FOOTBALL API.postman_environment.json`
and set the proper API_URL where the project is running.

Postman also provides an online version of the swagger definition:

`https://documenter.getpostman.com/view/1036615/RWThSfc8`

### Protocol buffers requests
In order to run the protocol buffer requests (`GET matches with filter`)
you need to select a binary file containing the params encoded.

In the subfolder `proto_requests` you can find 2 examples of already encoded
parameters:

- **div_SP1_param**: contains the parameter %{div: "SP1"}
- **div_SP1_season_201617_param**: contains the parameter %{div: "SP1", season: "201617"}

you can generate more examples using the iex console:

```elixir
iex(1)> encoded_params = %{div: "SP1", season: "201617"} |> FootballApi.Protobuf.Params.Params.new() |> FootballApi.Protobuf.Params.Params.encode()
<<10, 3, 83, 80, 49, 18, 6, 50, 48, 49, 54, 49, 55>>
iex(2) > {:ok, file} = File.open "somefile", [:write]
{:ok, #PID<0.352.0>}
iex(3)> IO.binwrite file, encoded_params
:ok
```
