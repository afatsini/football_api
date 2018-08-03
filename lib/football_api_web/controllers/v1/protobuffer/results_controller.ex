defmodule FootballApiWeb.V1.Protobuffer.ResultsController do
  @moduledoc false
  use FootballApiWeb, :controller

  alias FootballApi.DataServer
  alias FootballApi.Protobuf.Protobuf

  def index(conn, params) do
    results =
      DataServer.get_by([])
      |> Protobuf.encode()

    conn
    |> put_resp_header("content-type", "application/x-protobuf")
    |> send_resp(200, results)
  end
end
