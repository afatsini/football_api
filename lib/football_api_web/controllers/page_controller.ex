defmodule FootballApiWeb.PageController do
  use FootballApiWeb, :controller

  def index(conn, _params) do
    json(conn, %{"ping" => "pong"})
  end
end
