defmodule FootballApiWeb.V1.ResultsControllerTest do
  use FootballApiWeb.ConnCase

  describe "index/2" do
    test "return OK - 200 with json API result", %{conn: conn} do
      response =
        conn
        |> get(results_path(conn, :index))
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
            "type" => "results"
          }
          | _
        ],
        "jsonapi" => %{"version" => "1.0"}
      } = response
    end
  end
end
