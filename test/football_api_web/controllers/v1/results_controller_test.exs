defmodule FootballApiWeb.V1.ResultsControllerTest do
  use FootballApiWeb.ConnCase

  describe "index/2" do
    test "return OK - 200 with json result", %{conn: conn} do
      response =
        conn
        |> get(results_path(conn, :index))
        |> json_response(200)

      assert [
               %{
                 "" => _,
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
               }
               | _
             ] = response
    end
  end
end
