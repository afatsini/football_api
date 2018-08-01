defmodule FootballApiWeb.Router do
  use FootballApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json-api"])
  end

  scope "/", FootballApiWeb do
    get("/", PageController, :index)
  end

  scope "/v1", FootballApiWeb.V1 do
    pipe_through(:api)

    get("/results", ResultsController, :index)
  end
end
