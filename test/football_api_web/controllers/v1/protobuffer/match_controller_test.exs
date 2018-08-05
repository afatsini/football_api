defmodule FootballApiWeb.V1.Protobuffer.MatchControllerTest do
  use FootballApiWeb.ConnCase

  alias FootballApi.Protobuf.Match
  alias FootballApi.Protobuf.Params
  alias FootballApi.Protobuf.Error

  import Mock

  describe "GET index/2" do
    test "return OK - 200 with json Protocol Buffer result", %{conn: conn} do
      response =
        conn
        |> get("/v1/protobuffer/matches")

      assert response.status == 200

      assert Enum.member?(response.resp_headers, {"content-type", "application/x-protobuf"})

      decoded_body = Match.decode(response.resp_body)

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
      params = %{}
      encoded_params = params |> Params.Params.new() |> Params.Params.encode()

      response =
        conn
        |> put_req_header("content-type", "application/x-protobuf")
        |> post("/v1/protobuffer/matches", encoded_params)

      assert response.status == 200

      assert Enum.member?(response.resp_headers, {"content-type", "application/x-protobuf"})

      decoded_body = Match.decode(response.resp_body)

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
               Season: _,
               id: _
             } = decoded_body
    end

    test "return matches filtered by div and season param", %{conn: conn} do
      params = %{div: "SP1", season: "201617"}
      encoded_params = params |> Params.Params.new() |> Params.Params.encode()

      response =
        conn
        |> put_req_header("content-type", "application/x-protobuf")
        |> post("/v1/protobuffer/matches", encoded_params)

      decoded_body = Match.decode(response.resp_body)

      assert Map.get(decoded_body, :Div) == "SP1"
      assert Map.get(decoded_body, :Season) == "201617"
    end

    test "return single match searchin by id", %{conn: conn} do
      params = %{id: "1"}
      encoded_params = params |> Params.Params.new() |> Params.Params.encode()

      response =
        conn
        |> put_req_header("content-type", "application/x-protobuf")
        |> post("/v1/protobuffer/matches", encoded_params)

      decoded_body = Match.decode(response.resp_body)

      assert Map.get(decoded_body, :id) == "1"
    end

    test "return 404 for non-existing params", %{conn: conn} do
      params = %{season: "inexistent", div: "inexistent"}
      encoded_params = params |> Params.Params.new() |> Params.Params.encode()

      response =
        conn
        |> put_req_header("content-type", "application/x-protobuf")
        |> post("/v1/protobuffer/matches", encoded_params)

      assert response.status == 404
      assert Enum.member?(response.resp_headers, {"content-type", "application/x-protobuf"})
      decoded_response = Error.decode(response.resp_body)

      assert decoded_response == %{reason: "Not found"}
    end

    test "return 400 for validation errors", %{conn: conn} do
      with_mock FootballApiWeb.Schemas.GetMatches,
        validate_params: fn _params ->
          {:error, :bad_request}
        end do
        params = %{bad: "request"}
        encoded_params = params |> Params.Params.new() |> Params.Params.encode()

        response =
          conn
          |> put_req_header("content-type", "application/x-protobuf")
          |> post("/v1/protobuffer/matches", encoded_params)

        assert response.status == 400
        assert Enum.member?(response.resp_headers, {"content-type", "application/x-protobuf"})
        decoded_response = Error.decode(response.resp_body)

        assert decoded_response == %{reason: "Bad Request"}
      end
    end
  end
end
