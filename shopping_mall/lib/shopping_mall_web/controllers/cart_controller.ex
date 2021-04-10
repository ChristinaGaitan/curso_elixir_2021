defmodule ShoppingMallWeb.CartController do
  use ShoppingMallWeb, :controller

  def index(conn, _params) do
    render(conn, "cart_index.html")
  end
end
