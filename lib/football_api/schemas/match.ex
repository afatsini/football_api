defmodule FootballApi.Schemas.Match do
  @moduledoc """
    Representation of a Football match
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

  def new(map \\ %{}) do
    struct(Match, map)
  end

  def get_by(query, opts \\ []) do
    data_server = opts[:data_server] || DataServer

    if key_exist_for_query?(query, data_server) do
      results = data_server.get_by(query)
      {:ok, results}
    else
      {:error, {:not_found, :no_data_for_query}}
    end
  end

  defp key_exist_for_query?(query, data_server) do
    case query do
      %{div: nil} ->
        true

      %{season: nil} ->
        true

      _ ->
        data_server.get_keys()
        |> Enum.any?(fn {div, season} ->
          div == query[:div] && season == query[:season]
        end)
    end
  end
end
