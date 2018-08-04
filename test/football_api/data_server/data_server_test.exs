defmodule FootballApi.DataServer.DataServerTest do
  use ExUnit.Case, async: true

  alias FootballApi.DataServer
  alias FootballApi.Schemas.Match

  describe "start_link/1" do
    test "Server starts automatically when starting the project" do
      assert {:error, {:already_started, _pid}} = DataServer.start_link()
    end
  end

  describe "get_keys/0" do
    test "returns unique list of keys identiying stored data" do
      assert DataServer.get_keys() == [
               {"SP1", "201617"},
               {"SP1", "201516"},
               {"SP2", "201617"},
               {"SP2", "201516"},
               {"E0", "201617"},
               {"D1", "201617"}
             ]
    end
  end

  describe "get_by/1" do
    test "returns the list of entries based on the search criteria" do
      assert DataServer.get_by(div: "SP1", season: "201617") |> length == 380
    end

    test "returns all values if no criteria is provided" do
      assert DataServer.get_by() |> length == 2370
    end

    test "returns all matches that match query only" do
      assert DataServer.get_by(div: "SP1")
             |> Enum.map(fn entry -> Map.get(entry, :Div) end)
             |> Enum.uniq() == ["SP1"]
    end

    test "check the format of the stored match" do
      match = DataServer.get_by(div: "SP1") |> List.last()

      assert %Match{
               AwayTeam: "Levante",
               Date: "15/05/16",
               Div: "SP1",
               FTAG: "1",
               FTHG: "3",
               FTR: "H",
               HTAG: "0",
               HTHG: "2",
               HTR: "H",
               HomeTeam: "Vallecano",
               Season: "201516",
               id: "760"
             } = match
    end
  end
end
