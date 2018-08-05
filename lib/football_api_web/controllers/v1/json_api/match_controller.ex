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
  alias FootballApiWeb.Schemas.Paginator

  def index(conn, params) do
    with {:ok, schema} <- GetMatches.validate_params(params),
         query <- Map.from_struct(schema),
         {:ok, all_results} <- Match.get_by(query),
         {:ok, pagination} <- Paginator.validate_params(params),
         results <- Paginator.paginate(all_results, pagination) do
      render(conn, "index.json-api", data: results)
    else
      error -> error
    end
  end

  def show(conn, params) do
    with {:ok, schema} <- GetMatches.validate_params(params),
         query <- Map.from_struct(schema),
         {:ok, result} <- Match.get_by(query) do
      render(conn, "index.json-api", data: result)
    else
      error -> error
    end
  end
end
