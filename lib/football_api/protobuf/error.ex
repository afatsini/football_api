defmodule FootballApi.Protobuf.Error do
  @moduledoc """
      Allow conversion to protocol buffer format
  """
  use Protobuf, from: Path.expand("protos/error.proto", __DIR__)

  alias __MODULE__

  def encode(entry) do
    entry
    |> Error.Error.new()
    |> Error.Error.encode()
  end

  def decode(entry) do
    entry |> Error.Error.decode() |> Map.from_struct()
  end
end
