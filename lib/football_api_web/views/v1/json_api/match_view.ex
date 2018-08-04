defmodule FootballApiWeb.V1.JsonApi.MatchView do
  use FootballApiWeb, :view
  use JaSerializer.PhoenixView

  attributes([:AwayTeam, :Date, :Div, :FTAG, :FTHG, :FTR, :HTAG, :HTHG, :HTR, :HomeTeam, :Season])
end
