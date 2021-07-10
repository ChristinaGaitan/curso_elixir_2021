defmodule CostcoMallEeWeb.PageController do
  use CostcoMallEeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def app_index(conn, _params) do
    conn
    |> put_status(200)
    |> json(%{message: :ok})
  end
end
