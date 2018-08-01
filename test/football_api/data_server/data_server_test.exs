defmodule FootballApi.DataServer.DataServerTest do
  use ExUnit.Case, async: true

  alias FootballApi.DataServer

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

    test "filter with only one criteria returns all matches with the given criteria only" do
      assert DataServer.get_by(div: "SP1")
             |> Enum.map(fn entry -> entry["Div"] end)
             |> Enum.uniq() == ["SP1"]
    end

    test "check the format of the entries" do
      entry = DataServer.get_by(div: "SP1") |> List.last()

      assert %{
               "" => _,
               "AwayTeam" => _,
               "Date" => _,
               "Div" => _,
               "FTAG" => _,
               "FTHG" => _,
               "FTR" => _,
               "HTAG" => _,
               "HTHG" => _,
               "HTR" => _,
               "HomeTeam" => _,
               "Season" => _
             } = entry
    end
  end
end
