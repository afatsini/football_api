defmodule FootballApiWeb.V1.JsonApi.MatchControllerTest do
  @moduledoc """
    Controller test is used as integration test, going though all
    the real objects
  """

  use FootballApiWeb.ConnCase

  describe "index/2" do
    test "return OK - 200 with json API result", %{conn: conn} do
      response =
        conn
        |> get(match_path(conn, :index))
        |> json_response(200)

      %{
        "data" => [
          %{
            "attributes" => %{
              "AwayTeam" => _,
              "Date" => _,
              "Div" => _,
              "FTAG" => _,
              "FTHG" => _,
              "FTR" => _,
              "HTAG" => _,
              "HTHG" => _,
              "HTR" => _,
              "HomeTeam" => _,
              "Season" => _
            },
            "id" => _,
            "type" => "match"
          }
          | _
        ],
        "jsonapi" => %{"version" => "1.0"}
      } = response
    end
  end

  test "return results filtered by div param", %{conn: conn} do
    value = "SP1"

    response =
      conn
      |> get(match_path(conn, :index, %{div: value}))
      |> json_response(200)

    [div_from_result] =
      response["data"] |> Enum.map(fn result -> result["attributes"]["Div"] end) |> Enum.uniq()

    assert div_from_result == value
  end

  test "return results filtered by season param", %{conn: conn} do
    value = "201617"

    response =
      conn
      |> get(match_path(conn, :index, %{season: value}))
      |> json_response(200)

    [season_filter] =
      response["data"] |> Enum.map(fn result -> result["attributes"]["Season"] end) |> Enum.uniq()

    assert season_filter == value
  end

  test "return 404 for non-existing params", %{conn: conn} do
    params = %{season: :inexistent, div: :inexistent}

    response =
      conn
      |> get(match_path(conn, :index, params))
      |> json_response(404)

    assert response == %{"errors" => %{"detail" => "Not Found"}}
  end
end
