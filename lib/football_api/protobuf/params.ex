defmodule FootballApi.Protobuf.Params do
  @moduledoc """
      Allow conversion to protocol buffer format
  """
  use Protobuf, from: Path.expand("protos/params.proto", __DIR__)

  alias __MODULE__

  def encode(entry) when is_map(entry) do
    entry
    |> Params.Params.new()
    |> Params.Params.encode()
  end

  def decode(entry) do
    entry |> Params.Params.decode() |> Map.from_struct()
  end
end
