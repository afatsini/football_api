defmodule FootballApi.Protobuf.ProtobufTest do
  use ExUnit.Case, async: true

  alias FootballApi.Protobuf.Protobuf
  alias FootballApi.Protobuf.Protobuf.Result

  setup do
    decoded_protobuf = %{
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

    encoded_protobuf = decoded_protobuf |> Result.new() |> Result.encode()

    %{
      decoded_protobuf: decoded_protobuf,
      encoded_protobuf: encoded_protobuf
    }
  end

  describe "encode/1" do
    test "encode map to protobuffer", %{
      decoded_protobuf: decoded_protobuf,
      encoded_protobuf: encoded_protobuf
    } do
      encoded = Protobuf.encode(decoded_protobuf)

      assert encoded == encoded_protobuf
    end

    test "encode list of maps to protobuffer", %{
      decoded_protobuf: decoded_protobuf,
      encoded_protobuf: encoded_protobuf
    } do
      list_of_maps = [decoded_protobuf, decoded_protobuf, decoded_protobuf]
      encoded = Protobuf.encode(list_of_maps)

      Enum.each(encoded, fn result -> result == encoded_protobuf end)
    end
  end

  describe "dencode/1" do
    test "dencode map to protobuffer", %{
      decoded_protobuf: decoded_protobuf,
      encoded_protobuf: encoded_protobuf
    } do
      decoded_pb = Protobuf.decode(encoded_protobuf)

      assert decoded_protobuf == decoded_pb
    end
  end
end
