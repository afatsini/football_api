defmodule FootballApiWeb.PageControllerTest do
  use FootballApiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert json_response(conn, 200) == %{"ping" => "pong"}
  end
end
