defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    # IO.puts("Entrando al index")
    # IO.inspect(self())
    render(conn, "index.html")
  end

  def api(conn, _params) do
    text(conn, "This is a text response!")
  end
end
