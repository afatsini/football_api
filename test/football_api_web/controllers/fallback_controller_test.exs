defmodule FootballApiWeb.FallbackControllerTest do
  use ExUnit.Case, async: true

  alias FootballApiWeb.FallbackController

  use FootballApiWeb.ConnCase

  describe "call/3" do
    test "when the input validation failed", %{conn: conn} do
      error = {:error, {:bad_request, [{:some_error, :that_happened}]}}

      conn = FallbackController.call(conn, error)

      expected_body = "{\"errors\":{\"detail\":\"[some_error: :that_happened]\"},\"code\":400}"
      assert conn.resp_body == expected_body
      assert conn.status == 400
    end

    test "when not found occured", %{conn: conn} do
      error = {:error, {:not_found, "Not found!"}}

      conn = FallbackController.call(conn, error)

      expected_body = "{\"errors\":{\"detail\":\"Not Found\"}}"
      assert conn.resp_body == expected_body
      assert conn.status == 404
    end

    test "when the developer forgets to catch an error", %{conn: conn} do
      error = {:error, :some_error}

      conn = FallbackController.call(conn, error)

      expected_body = "{\"errors\":{\"detail\":\"Internal Server Error\"}}"
      assert conn.resp_body == expected_body
      assert conn.status == 500
    end

    Enum.each([true, {:something, :that_doesnt_match}, "string", 15], fn value ->
      test "when passing something random: #{inspect(value)}", %{conn: conn} do
        conn = FallbackController.call(conn, unquote(value))
        assert conn.resp_body == "{\"errors\":{\"detail\":\"Internal Server Error\"}}"
        assert conn.status == 500
      end
    end)
  end
end
