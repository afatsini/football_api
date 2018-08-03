defmodule FootballApiWeb.Router do
  use FootballApiWeb, :router

  pipeline :jsonapi do
    plug(:accepts, ["json-api"])
  end

  pipeline :protobuffer do
    plug(:accepts, ["x-protobuf"])
  end

  scope "/", FootballApiWeb do
    get("/", PageController, :index)
  end

  scope "/v1/json-api", FootballApiWeb.V1.JsonApi do
    pipe_through(:jsonapi)

    get("/results", ResultsController, :index)
  end

  scope "/v1/protobuffer", FootballApiWeb.V1.Protobuffer do
    pipe_through(:protobuffer)

    get("/results", ResultsController, :index)
  end
end
