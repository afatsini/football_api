defmodule FootballApiWeb.FallbackController do
  use Phoenix.Controller
  import FootballApiWeb.Controller

  alias Plug.Conn

  @spec call(Conn.t(), any) :: Conn.t()
  def call(conn, {:error, {:bad_request, errors}}), do: bad_input(conn, errors)
  def call(conn, {:error, {:not_found, term}}), do: not_found(conn, inspect(term))
  def call(conn, error), do: server_error(conn, error)
end
