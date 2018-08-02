defmodule FootballApiWeb.JsonApi.ResultsView do
  use FootballApiWeb, :view
  use JaSerializer.PhoenixView

  def id(struct, _conn) do
    struct[:""]
  end

  attributes([:AwayTeam, :Date, :Div, :FTAG, :FTHG, :FTR, :HTAG, :HTHG, :HTR, :HomeTeam, :Season])
end
