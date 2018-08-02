defmodule FootballApiWeb.Protobuffer.ResultsController do
  @moduledoc false
  use FootballApiWeb, :controller

  alias FootballApi.DataServer
  alias FootballApi.Protobuf.Results.Result

  def index(conn, _params) do
    results =
      DataServer.get_by([])
      |> Enum.map(fn result -> result |> Result.new() |> Result.encode() end)

    conn
    |> put_resp_header("content-type", "application/x-protobuf")
    |> send_resp(200, results)
  end
end
