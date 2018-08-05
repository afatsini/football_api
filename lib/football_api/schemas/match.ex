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
      {:error, :not_found}
    end
  end

  defp key_exist_for_query?(query, data_server) do
    search_query =
      case query do
        %{div: nil, season: nil} ->
          fn _ -> true end

        %{div: nil} ->
          fn {_div, season} -> season == query[:season] end

        %{season: nil} ->
          fn {div, _season} -> div == query[:div] end

        _ ->
          fn {div, season} -> div == query[:div] && season == query[:season] end
      end

    data_server.get_keys() |> Enum.any?(&search_query.(&1))
  end
end
