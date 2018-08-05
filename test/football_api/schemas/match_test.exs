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

  describe "get_by/1" do
    input_params = [
      {nil, nil},
      {"SP1", nil},
      {"SP1", "201617"},
      {nil, :inexistent}
    ]

    setup do
      defmodule FakeDataServer do
        def get_by(query) do
          send(self(), {:get_by, query})
        end

        def get(id) do
          send(self(), {:get, id})
        end
      end

      %{data_server: FakeDataServer}
    end

    Enum.each(input_params, fn query ->
      test "query #{inspect(query)} are send to dataserver", %{data_server: data_server} do
        {div, season} = unquote(query)
        params = %{div: div, season: season}

        Match.get_by(params, data_server: data_server)

        assert_received({:get_by, params})
      end
    end)

    test "resturns {:ok, result_list} format" do
      params = %{div: "SP1", season: "201617"}

      assert {:ok,
              [
                %FootballApi.Schemas.Match{
                  AwayTeam: "Eibar",
                  Date: "19/08/16",
                  Div: "SP1",
                  FTAG: "1",
                  FTHG: "2",
                  FTR: "H",
                  HTAG: "0",
                  HTHG: "0",
                  HTR: "D",
                  HomeTeam: "La Coruna",
                  Season: "201617",
                  id: "1"
                }
              ]} = Match.get_by(params)
    end
  end

  describe "get/1" do
    test "get by inexistent id" do
      assert {:error, :not_found} = Match.get(:inexistent)
    end

    test "get by existing id" do
      assert {:ok,
              [
                %FootballApi.Schemas.Match{
                  AwayTeam: "Eibar",
                  Date: "19/08/16",
                  Div: "SP1",
                  FTAG: "1",
                  FTHG: "2",
                  FTR: "H",
                  HTAG: "0",
                  HTHG: "0",
                  HTR: "D",
                  HomeTeam: "La Coruna",
                  Season: "201617",
                  id: "1"
                }
              ]} = Match.get("1")
    end
  end
end
