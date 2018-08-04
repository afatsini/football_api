defmodule FootballApiWeb.JsonController do
  @moduledoc false

  import Phoenix.Controller
  import Plug.Conn

  alias Plug.Conn

  alias FootballApiWeb.ErrorView

  @spec init(any) :: any
  def init(default), do: default

  @spec call(Conn.t(), any) :: Conn.t()
  def call(conn, {:error, :bad_request}), do: do_error(conn, 400)
  def call(conn, {:error, :not_found}), do: do_error(conn, 404)

  @spec do_error(Conn.t(), http_code :: pos_integer) :: Conn.t()
  defp do_error(conn, http_code) do
    conn
    |> put_status(http_code)
    |> render(ErrorView, "#{http_code}.json")
    |> halt
  end
end
