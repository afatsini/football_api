defmodule FootballApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :football_api,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls.json": :test]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {FootballApi.Application, []},
      extra_applications: [:logger, :runtime_tools, :exprotobuf, :plug_logger_json]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.1"},
      {:phoenix_ecto, "~> 3.2"},
      {:cowboy, "~> 1.0"},
      {:csv, "~> 2.0.0"},
      {:ja_serializer, "~> 0.13.0"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:credo, "~> 0.9", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.9", only: :test},
      {:exprotobuf, "~> 1.2.9"},
      {:mock, "~> 0.3.0", only: :test},
      {:plug_logger_json, "~> 0.6.0"},
      {:scrivener_list, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["test"]
    ]
  end
end
