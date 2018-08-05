defmodule FootballApi.Schemas.Match do
  @moduledoc """
    Representation of a Football match.
    Now it's using the DataServer Repo, but it can be changed
    by any other repo like Ecto.Repo
  """
  alias __MODULE__
  alias FootballApi.DataServer

  use Ecto.Schema

  embedded_schema do
    field(:Div, :string)
    field(:Season, :string)
    field(:Date, :string)
    field(:HomeTeam, :string)
    field(:AwayTeam, :string)
    field(:FTHG, :integer)
    field(:FTAG, :integer)
    field(:FTR, :string)
    field(:HTHG, :integer)
    field(:HTAG, :integer)
    field(:HTR, :string)
  end

  @spec new(map) :: struct
  def new(map \\ %{}) do
    struct(Match, map)
  end

  @spec get_by(map, list) :: {:error, :not_found} | {:ok, list}
  def get_by(query, opts \\ []) do
    data_server = opts[:data_server] || DataServer

    case data_server.get_by(query) do
      [] -> {:error, :not_found}
      results -> {:ok, results}
    end
  end

  @spec get(integer, list) :: {:error, :not_found} | {:ok, struct}
  def get(id, opts \\ []) do
    data_server = opts[:data_server] || DataServer

    case data_server.get(id) do
      nil -> {:error, :not_found}
      result -> {:ok, result}
    end
  end
end
