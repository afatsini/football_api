defmodule FootballApiWeb.JsonController do
  @moduledoc false

  import Phoenix.Controller
  import Plug.Conn

  alias Plug.Conn

  alias FootballApiWeb.ErrorView

  @spec init(any) :: any
  def init(default), do: default

  @spec call(Conn.t(), any) :: Conn.t()
  def call(conn, {:error, :bad_request}), do: bad_input(conn)
  def call(conn, {:error, :not_found}), do: not_found(conn)

  @spec bad_input(Conn.t()) :: Conn.t()
  def bad_input(conn), do: do_error(conn, 400)

  @spec not_found(Conn.t()) :: Conn.t()
  def not_found(conn), do: do_error(conn, 404)

  @spec unprocessable_entity(Conn.t()) :: Conn.t()
  def unprocessable_entity(conn),
    do: do_error(conn, 422)

  @spec do_error(Conn.t(), http_code :: pos_integer) :: Conn.t()
  defp do_error(conn, http_code) do
    conn
    |> put_status(http_code)
    |> render(ErrorView, "#{http_code}.json")
    |> halt
  end
end
