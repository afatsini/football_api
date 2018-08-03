defmodule FootballApiWeb.V1.JsonApi.MatchController do
  @moduledoc """
    Result controller in charge of receiving the filter,
    passing it to the business layer and render the results
  """

  use FootballApiWeb, :controller

  alias FootballApi.Schemas.Match
  alias FootballApiWeb.Schemas.GetMatches

  def index(conn, params) do
    with {:ok, schema} <- GetMatches.validate_params(params),
         query <- Map.from_struct(schema),
         results <- Match.get_by(query) do
      render(conn, "index.json-api", data: results)
    else
      error -> error
    end
  end
end
