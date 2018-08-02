defmodule FootballApi.Protobuf.Results do
  use Protobuf, """
    message Result {
      required string Div = 2;
      required string Season = 3;
      required string Date = 4;
      required string HomeTeam = 5;
      required string AwayTeam = 6;
      required string FTHG = 7;
      required string FTAG = 8;
      required string FTR = 9;
      required string HTHG = 10;
      required string HTAG = 11;
      required string HTR = 12;
    }
  """
end
