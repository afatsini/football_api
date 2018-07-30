defmodule FootballApiWeb.Router do
  use FootballApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", FootballApiWeb do
    pipe_through(:api)

    get("/", PageController, :index)
  end
end
