defmodule FootballApi.Protobuf.ResultsTest do
  use ExUnit.Case, async: true

  alias FootballApi.Protobuf.Results
  alias FootballApi.Protobuf.Results.Result

  setup do
    result_map = %{
      "": "1223",
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
      Season: "201516"
    }

    %{result_map: result_map}
  end

  describe "to_proto/1" do
    test "encode map to protobuffer", %{result_map: result_map} do
      encoded = Results.to_proto(result_map)
      decoded_pb = Result.decode(encoded)

      assert %Result{
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
               Season: "201516"
             } == decoded_pb
    end

    test "encode list of maps to protobuffer", %{result_map: result_map} do
      list_of_maps = [result_map, result_map, result_map]
      encoded = Results.to_proto(list_of_maps)

      decoded_list = encoded |> Enum.map(fn result -> Result.decode(result) end)

      assert length(decoded_list) == 3

      decoded_pb = decoded_list |> Enum.uniq()

      assert [
               %Result{
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
                 Season: "201516"
               }
             ] == decoded_pb
    end
  end
end
