defmodule FootballApi.Protobuf.Match do
  @moduledoc """
      Allow conversion to protocol buffer format
  """
  use Protobuf, from: Path.expand("protos/match.proto", __DIR__)

  alias __MODULE__
  alias FootballApi.Schemas.Match, as: MatchObject

  def encode(entry) when is_map(entry) do
    entry
    |> Map.from_struct()
    |> Match.Match.new()
    |> Match.Match.encode()
  end

  def encode(entries) when is_list(entries) do
    entries
    |> Enum.map(fn result -> encode(result) end)
  end

  def decode(entry) do
    entry |> Match.Match.decode() |> Map.from_struct() |> MatchObject.new()
  end
end
