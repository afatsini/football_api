defmodule FootballApi.Protobuf.Results do
  @moduledoc """
      Allow conversion to protocol buffer format
  """
  use Protobuf, from: Path.expand("result.proto", __DIR__)

  alias FootballApi.Protobuf.Results.Result

  def to_proto(entry) when is_map(entry) do
    entry
    |> Result.new()
    |> Result.encode()
  end

  def to_proto(entries) when is_list(entries) do
    entries
    |> Enum.map(fn result -> to_proto(result) end)
  end
end
