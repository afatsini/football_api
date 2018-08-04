defmodule FootballApiWeb.ProtoController do
  @moduledoc false

  import Plug.Conn
  alias Plug.Conn
  alias FootballApi.Protobuf.Error

  @spec init(any) :: any
  def init(default), do: default

  @spec call(Conn.t(), any) :: Conn.t()
  def call(conn, {:error, :bad_request}), do: bad_input(conn)
  def call(conn, {:error, :not_found}), do: not_found(conn)
  def call(conn, error), do: server_error(conn, error)

  @typep reason :: any

  @spec bad_input(Conn.t(), reason) :: Conn.t()
  def bad_input(conn, reason \\ "Bad Request"), do: do_error(conn, 400, reason)

  @spec not_found(Conn.t(), reason) :: Conn.t()
  def not_found(conn, reason \\ "Not found"), do: do_error(conn, 404, reason)

  @spec unprocessable_entity(Conn.t(), reason) :: Conn.t()
  def unprocessable_entity(conn, reason \\ "Unprocessable entity"),
    do: do_error(conn, 422, reason)

  @spec server_error(Conn.t(), reason) :: Conn.t()
  def server_error(conn, reason), do: do_error(conn, 500, reason)

  @spec do_error(Conn.t(), http_code :: pos_integer, reason) :: Conn.t()
  defp do_error(conn, http_code, reason) do
    encoded_reason = Error.encode(%{reason: reason})

    conn
    |> resp(http_code, encoded_reason)
    |> put_resp_header("content-type", "application/x-protobuf")
    |> halt
  end
end
