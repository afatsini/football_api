defmodule FootballApiWeb.V1.JsonApi.MatchControllerTest do
  @moduledoc """
    Controller test is used as integration test, going though all
    the real objects.
    Non happy path mocked
  """

  import Mock

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

    test "paginates the result when no pagination parameters are given", %{conn: conn} do
      response =
        conn
        |> get(match_path(conn, :index))
        |> json_response(200)

      %{
        "links" => %{
          "last" => "/v1/json-api/matches?page[number]=2&page[size]=10",
          "next" => "/v1/json-api/matches?page[number]=2&page[size]=10",
          "self" => "/v1/json-api/matches?page[number]=1&page[size]=10"
        }
      } = response
    end

    test "paginates the result with pagination parameters", %{conn: conn} do
      response =
        conn
        |> get(match_path(conn, :index, page_size: 1, page_number: 2))
        |> json_response(200)

      %{
        "data" => [
          %{
            "attributes" => %{
              "AwayTeam" => "Werder Bremen",
              "Date" => "07/04/17",
              "Div" => "D1",
              "FTAG" => "2",
              "FTHG" => "2",
              "FTR" => "D",
              "HTAG" => "2",
              "HTHG" => "0",
              "HTR" => "A",
              "HomeTeam" => "Ein Frankfurt",
              "Season" => "201617"
            },
            "id" => "2308",
            "type" => "match"
          }
        ],
        "jsonapi" => %{"version" => "1.0"},
        "links" => %{
          "first" => "/v1/json-api/matches?page[number]=1&page[size]=1&page_number=2&page_size=1",
          "last" => "/v1/json-api/matches?page[number]=11&page[size]=1&page_number=2&page_size=1",
          "next" => "/v1/json-api/matches?page[number]=3&page[size]=1&page_number=2&page_size=1",
          "prev" => "/v1/json-api/matches?page[number]=1&page[size]=1&page_number=2&page_size=1",
          "self" => "/v1/json-api/matches?page[number]=2&page[size]=1&page_number=2&page_size=1"
        }
      } = response
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
        response["data"]
        |> Enum.map(fn result -> result["attributes"]["Season"] end)
        |> Enum.uniq()

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

    test "return 400 for validation errors", %{conn: conn} do
      with_mock FootballApiWeb.Schemas.GetMatches,
        validate_params: fn _params ->
          {:error, :bad_request}
        end do
        params = %{bad: :request}

        response =
          conn
          |> get(match_path(conn, :index, params))
          |> json_response(400)

        assert response == %{"errors" => %{"detail" => "Bad Request"}}
      end
    end
  end

  describe "show/2" do
    test "return OK - 200 with json API result when id exists", %{conn: conn} do
      response =
        conn
        |> get(match_path(conn, :show, 1))
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

    test "return 404 when id doesnt exist", %{conn: conn} do
      assert %{"errors" => %{"detail" => "Not Found"}} =
               conn
               |> get(match_path(conn, :show, :non_existing))
               |> json_response(404)
    end
  end
end
