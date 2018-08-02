defmodule FootballApiWeb.V1.ResultsController do
  @moduledoc false
  use FootballApiWeb, :controller

  alias FootballApi.DataServer
  alias FootballApi.Schemas.GetResults

  def index(conn, params) do
    with {:ok, schema} <- GetResults.validate_params(params) do
      results = DataServer.get_by([schema])
      render(conn, "index.json-api", data: results)
    else
      error -> error
    end
  end
end
