defmodule FootballApi.Protobuf.Protobuf do
  @moduledoc """
      Allow conversion to protocol buffer format
  """
  use Protobuf, from: Path.expand("result.proto", __DIR__)

  alias FootballApi.Protobuf.Protobuf.Result

  def encode(entry) when is_map(entry) do
    entry
    |> Result.new()
    |> Result.encode()
  end

  def encode(entries) when is_list(entries) do
    entries
    |> Enum.map(fn result -> encode(result) end)
  end

  def decode(entry) do
    Result.decode(entry)
  end
end
