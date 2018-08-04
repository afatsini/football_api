defmodule FootballApiWeb.JsonController do
  @moduledoc false

  import Phoenix.Controller
  import Plug.Conn

  alias Plug.Conn

  alias FootballApiWeb.ErrorView

  @spec init(any) :: any
  def init(default), do: default

  @spec call(Conn.t(), any) :: Conn.t()
  def call(conn, {:error, {:bad_request, errors}}), do: bad_input(conn, errors)
  def call(conn, {:error, {:not_found, term}}), do: not_found(conn, term)
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
    conn
    |> put_status(http_code)
    |> render(ErrorView, "#{http_code}.json", %{detail: reason})
    |> halt
  end
end
