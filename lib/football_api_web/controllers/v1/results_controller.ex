defmodule FootballApiWeb.V1.ResultsController do
  @moduledoc """
    Result controller in charge of receiving the filter,
    passing it to the business layer and render the results
  """
  use FootballApiWeb, :controller

  alias FootballApi.DataServer
  alias FootballApi.Schemas.GetResults

  def index(conn, params) do
    with {:ok, schema} <- GetResults.validate_params(params),
         query <- Map.from_struct(schema),
         results <- DataServer.get_by(query) do
      render(conn, "index.json-api", data: results)
    else
      error -> error
    end
  end
end
