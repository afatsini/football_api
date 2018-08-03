defmodule FootballApiWeb.V1.Protobuffer.ResultsController do
  @moduledoc false
  use FootballApiWeb, :controller

  alias FootballApi.DataServer
  alias FootballApi.Protobuf.Results

  def index(conn, params) do
    results =
      DataServer.get_by([])
      |> Results.encode()

    conn
    |> put_resp_header("content-type", "application/x-protobuf")
    |> send_resp(200, results)
  end
end
