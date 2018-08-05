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

    defmodule FakeDataServer do
      def get_by(query) do
        send(self(), {:query, query})
      end

      def get_keys() do
        [
          {"SP1", "201617"},
          {"SP1", "201516"},
          {"SP2", "201617"},
          {"SP2", "201516"},
          {"E0", "201617"},
          {"D1", "201617"}
        ]
      end
    end

    %{
      map: map,
      data_server: FakeDataServer
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
    test "query dataserver if params are nil", %{data_server: data_server} do
      params = %{div: nil, season: nil}

      assert {:ok, {:query, %{div: nil, season: nil}}} =
               Match.get_by(params, data_server: data_server)

      assert_received({:query, params})
    end

    test "query dataserver if one param is nil", %{data_server: data_server} do
      params = %{div: "SP1", season: nil}

      assert {:ok, {:query, %{div: "SP1", season: nil}}} =
               Match.get_by(params, data_server: data_server)

      assert_received({:query, params})
    end

    test "query dataserver if parms are in key list", %{data_server: data_server} do
      params = %{div: "SP1", season: "201617"}

      assert {:ok, {:query, %{div: "SP1", season: "201617"}}} =
               Match.get_by(params, data_server: data_server)

      assert_received({:query, params})
    end

    test "do NOT query dataserver if parms are NOT in key list", %{data_server: data_server} do
      params = %{div: "SP1", season: :inexistent}
      assert {:error, :not_found} = Match.get_by(params, data_server: data_server)

      refute_received({:query, _})
    end
  end
end
