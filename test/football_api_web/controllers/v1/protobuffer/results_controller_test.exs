defmodule FootballApiWeb.V1.Protobuffer.ResultsControllerTest do
  use FootballApiWeb.ConnCase

  alias FootballApi.Protobuf.Protobuf
  alias FootballApi.Protobuf.Protobuf.Result
  alias FootballApi.Protobuf.ProtoParams

  describe "GET index/2" do
    test "return OK - 200 with json Protocol Buffer result", %{conn: conn} do
      response =
        conn
        |> get("/v1/protobuffer/results")

      assert response.status == 200

      assert Enum.member?(response.resp_headers, {"content-type", "application/x-protobuf"})

      decoded_body = Protobuf.decode(response.resp_body)

      assert %{
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

  describe "POST index/2" do
    test "return OK - 200 with json Protocol Buffer result", %{conn: conn} do
      params = %{div: "SP1", season: "201617"}
      encoded_params = params |> ProtoParams.Params.new() |> ProtoParams.Params.encode()

      response =
        conn
        |> put_req_header("content-type", "application/x-protobuf")
        |> post("/v1/protobuffer/results", encoded_params)

      assert response.status == 200

      assert Enum.member?(response.resp_headers, {"content-type", "application/x-protobuf"})

      decoded_body = Protobuf.decode(response.resp_body)

      assert %{
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
