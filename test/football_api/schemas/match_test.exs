defmodule FootballApi.Schemas.MatchTest do
  use ExUnit.Case, async: true

  alias FootballApi.Schemas.Match

  setup do
    map = %{
      AwayTeam: "Mallorca",
      Date: "22/08/15",
      Div: "SP2",
      FTAG: "0",
      FTHG: "2",
      FTR: "H",
      HTAG: "0",
      HTHG: "1",
      HTR: "H",
      HomeTeam: "Alcorcon",
      Season: "201516",
      id: 12
    }

    %{
      map: map
    }
  end

  describe "new/1" do
    test "Creates a match from map", %{
      map: map
    } do
      match = Match.new(map)

      assert match == %Match{
               AwayTeam: "Mallorca",
               Date: "22/08/15",
               Div: "SP2",
               FTAG: "0",
               FTHG: "2",
               FTR: "H",
               HTAG: "0",
               HTHG: "1",
               HTR: "H",
               HomeTeam: "Alcorcon",
               Season: "201516",
               id: 12
             }
    end
  end
end
