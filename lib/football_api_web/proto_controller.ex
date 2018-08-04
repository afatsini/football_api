defmodule FootballApiWeb.ProtoController do
  @moduledoc false

  import Plug.Conn
  alias Plug.Conn
  alias FootballApi.Protobuf.Error

  @spec init(any) :: any
  def init(default), do: default

  @spec call(Conn.t(), any) :: Conn.t()
  def call(conn, {:error, :bad_request}), do: do_error(conn, 400, "Bad Request")
  def call(conn, {:error, :not_found}), do: do_error(conn, 404, "Not found")

  @typep reason :: any

  @spec do_error(Conn.t(), http_code :: pos_integer, reason) :: Conn.t()
  defp do_error(conn, http_code, reason) do
    encoded_reason = Error.encode(%{reason: reason})

    conn
    |> resp(http_code, encoded_reason)
    |> put_resp_header("content-type", "application/x-protobuf")
    |> halt
  end
end
