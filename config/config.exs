# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :football_api,
  ecto_repos: [FootballApi.Repo]

# Configures the endpoint
config :football_api, FootballApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lxL/H9XHjGl3dvrfOxA4FDEBbmykQZLHmgqqYvJl63WKKNejCl3D79L1EWtXfeGa",
  render_errors: [view: FootballApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FootballApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
