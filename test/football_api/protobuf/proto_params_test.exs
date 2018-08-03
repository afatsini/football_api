defmodule FootballApi.Protobuf.ProParamsTest do
  use ExUnit.Case, async: true

  alias FootballApi.Protobuf.ProtoParams
  alias FootballApi.Protobuf.ProtoParams.Params

  setup do
    params_map = %{
      div: "SP2",
      season: "201516"
    }

    decoded_protobuf = %{
      div: "SP2",
      season: "201516"
    }

    encoded_protobuf = params_map |> Params.new() |> Params.encode()

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
      encoded = ProtoParams.encode(params_map)

      assert encoded == encoded_protobuf
    end
  end

  describe "dencode/1" do
    test "dencode map to protobuffer", %{
      decoded_protobuf: decoded_protobuf,
      encoded_protobuf: encoded_protobuf
    } do
      decoded_pb = ProtoParams.decode(encoded_protobuf)

      assert decoded_protobuf == decoded_pb
    end
  end
end
