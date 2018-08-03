defmodule FootballApi.Protobuf.ProtoParams do
  @moduledoc """
      Allow conversion to protocol buffer format
  """
  use Protobuf, from: Path.expand("params.proto", __DIR__)

  alias FootballApi.Protobuf.ProtoParams.Params

  def encode(entry) when is_map(entry) do
    entry
    |> Params.new()
    |> Params.encode()
  end

  def decode(entry) do
    decoded_entry = Params.decode(entry)
    %{div: decoded_entry.div, season: decoded_entry.season}
  end
end
