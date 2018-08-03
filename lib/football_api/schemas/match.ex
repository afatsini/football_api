defmodule FootballApi.Schemas.Match do
  @moduledoc """
    Representation of a Football match
  """
  alias __MODULE__
  alias FootballApi.DataServer

  defstruct [:Div, :Season, :Date, :HomeTeam, :AwayTeam, :FTHG, :FTAG, :FTR, :HTHG, :HTAG, :HTR]

  def new(map \\ %{}) do
    struct(Match, map)
  end

  def get_by(query) do
    DataServer.get_by(query)
  end
end
