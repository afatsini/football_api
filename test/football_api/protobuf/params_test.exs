defmodule FootballApi.Protobuf.ParamsTest do
  use ExUnit.Case, async: true

  alias FootballApi.Protobuf.Params

  setup do
    params_map = %{
      div: "SP2",
      season: "201516",
      id: "1"
    }

    decoded_protobuf = %{
      div: "SP2",
      season: "201516",
      id: "1"
    }

    encoded_protobuf = params_map |> Params.Params.new() |> Params.Params.encode()

    %{
      params_map: params_map,
      decoded_protobuf: decoded_protobuf,
      encoded_protobuf: encoded_protobuf
    }
  end

  describe "encode/1" do
    test "encode map to protobuffer", %{
      params_map: params_map,
      encoded_protobuf: encoded_protobuf
    } do
      encoded = Params.encode(params_map)

      assert encoded == encoded_protobuf
    end
  end

  describe "dencode/1" do
    test "dencode map to protobuffer", %{
      decoded_protobuf: decoded_protobuf,
      encoded_protobuf: encoded_protobuf
    } do
      decoded_pb = Params.decode(encoded_protobuf)

      assert decoded_protobuf == decoded_pb
    end
  end
end
