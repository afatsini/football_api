defmodule FootballApiWeb.V1.JsonApi.MatchController do
  @moduledoc """
    Result controller in charge of receiving the filter,
    passing it to the business layer and render the results.
    The endpoint returns a JSONApi format
  """

  use FootballApiWeb, :controller

  action_fallback(FootballApiWeb.JsonController)

  alias FootballApi.Schemas.Match
  alias FootballApiWeb.Schemas.GetMatches

  def index(conn, params) do
    with {:ok, schema} <- GetMatches.validate_params(params),
         query <- Map.from_struct(schema),
         {:ok, results} <- Match.get_by(query) do
      render(conn, "index.json-api", data: results)
    else
      error -> error
    end
  end
end
