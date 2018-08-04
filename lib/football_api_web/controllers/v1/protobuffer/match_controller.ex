defmodule FootballApiWeb.V1.Protobuffer.MatchController do
  @moduledoc false
  use FootballApiWeb, :controller

  alias FootballApi.Schemas.Match
  alias FootballApi.Protobuf
  alias FootballApiWeb.Schemas.GetMatches

  def index(conn, _params) do
    {:ok, body_params, _} = read_body(conn)

    with decoded_params <- Protobuf.Params.decode(body_params),
         {:ok, schema} <- GetMatches.validate_params(decoded_params),
         query <- Map.from_struct(schema),
         {:ok, results} <- Match.get_by(query),
         encoded_results <- Protobuf.Match.encode(results) do
      conn
      |> put_resp_header("content-type", "application/x-protobuf")
      |> send_resp(200, encoded_results)
    else
      {:error, {:not_found, _}} ->
        conn
        |> put_resp_header("content-type", "application/x-protobuf")
        |> put_status(404)
      error -> error
    end
  end
end
