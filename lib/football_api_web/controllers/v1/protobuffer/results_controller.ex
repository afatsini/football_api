defmodule FootballApiWeb.V1.Protobuffer.ResultsController do
  @moduledoc false
  use FootballApiWeb, :controller

  alias FootballApi.DataServer
  alias FootballApi.Protobuf
  alias FootballApi.Schemas.GetResults

  def index(conn, _params) do
    {:ok, body_params, _} = read_body(conn)

    with decoded_params <- Protobuf.ProtoParams.decode(body_params),
         {:ok, schema} <- GetResults.validate_params(decoded_params),
         query <- Map.from_struct(schema),
         results <- DataServer.get_by(query),
         encoded_results <- Protobuf.Protobuf.encode(results) do
      conn
      |> put_resp_header("content-type", "application/x-protobuf")
      |> send_resp(200, encoded_results)
    else
      error -> error
    end
  end
end
