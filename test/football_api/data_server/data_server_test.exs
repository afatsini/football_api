defmodule FootballApi.DataServer.DataServerTest do
  use ExUnit.Case, async: true

  alias FootballApi.DataServer
  alias FootballApi.Schemas.Match

  describe "start_link/1" do
    test "Server starts automatically when starting the project" do
      assert {:error, {:already_started, _pid}} = DataServer.start_link()
    end
  end

  describe "get_by/1" do
    test "returns the list of entries based on the search criteria" do
      assert DataServer.get_by(div: "SP1", season: "201617") |> length == 1
    end

    test "returns all values if no criteria is provided" do
      assert DataServer.get_by() |> length == 11
    end

    test "returns all matches that match query only" do
      assert DataServer.get_by(div: "SP1")
             |> Enum.map(fn entry -> Map.get(entry, :Div) end)
             |> Enum.uniq() == ["SP1"]
    end

    test "check the format of the stored match" do
      match = DataServer.get_by(div: "SP1") |> List.last()

      assert %Match{
               AwayTeam: "Ath Bilbao",
               Date: "20/03/16",
               Div: "SP1",
               FTAG: "1",
               FTHG: "2",
               FTR: "H",
               HTAG: "1",
               HTHG: "0",
               HTR: "A",
               HomeTeam: "Espanol",
               Season: "201516",
               id: "677"
             } = match
    end
  end
end
