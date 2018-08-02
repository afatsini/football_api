defmodule FootballApiWeb.V1.ResultsController do
  @moduledoc false
  use FootballApiWeb, :controller

  alias FootballApi.DataServer

  def index(conn, _params) do
    results = DataServer.get_by([])
    render(conn, "index.json-api", data: results)
  end
end
