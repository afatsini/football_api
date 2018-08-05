defmodule FootballApiWeb.V1.Protobuffer.MatchController do
  @moduledoc """
    Result controller in charge of receiving the filter,
    passing it to the business layer and render the results.
    The endpoint returns a PROTOCOL BUFFER format
  """

  use FootballApiWeb, :controller

  action_fallback(FootballApiWeb.ProtoController)

  alias FootballApi.Schemas.Match
  alias FootballApi.Protobuf
  alias FootballApiWeb.Schemas.GetMatches
  alias FootballApiWeb.Schemas.Paginator

  def index(conn, _params) do
    {:ok, body_params, _} = read_body(conn)

    with decoded_params <- Protobuf.Params.decode(body_params),
         {:ok, schema} <- GetMatches.validate_params(decoded_params),
         query <- Map.from_struct(schema),
         {:ok, all_results} <- Match.get_by(query),
         {:ok, pagination} <- Paginator.validate_params(decoded_params),
         results <- Paginator.paginate(all_results, pagination),
         encoded_results <- Protobuf.Match.encode(results.entries) do
      conn
      |> put_resp_header("content-type", "application/x-protobuf")
      |> send_resp(200, encoded_results)
    else
      error -> error
    end
  end
end
