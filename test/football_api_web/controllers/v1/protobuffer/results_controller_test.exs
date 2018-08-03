defmodule FootballApiWeb.V1.Protobuffer.ResultsControllerTest do
  use FootballApiWeb.ConnCase

  alias FootballApi.Protobuf.Protobuf
  alias FootballApi.Protobuf.Protobuf.Result

  describe "GET index/2" do
    test "return OK - 200 with json Protocol Buffer result", %{conn: conn} do
      response =
        conn
        |> get("/v1/protobuffer/results")

      assert response.status == 200

      assert Enum.member?(response.resp_headers, {"content-type", "application/x-protobuf"})

      decoded_body = Protobuf.decode(response.resp_body)

      assert %Result{
               AwayTeam: _,
               Date: _,
               Div: _,
               FTAG: _,
               FTHG: _,
               FTR: _,
               HTAG: _,
               HTHG: _,
               HTR: _,
               HomeTeam: _,
               Season: _
             } = decoded_body
    end
  end
end
