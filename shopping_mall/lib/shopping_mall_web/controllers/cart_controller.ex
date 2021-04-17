defmodule ShoppingMallWeb.CartController do
  use ShoppingMallWeb, :controller
  alias ShoppingMall.CartAgent

  def index(conn, _params) do
    cart = CartAgent.value()
    render(conn, "cart_index.html", cart: cart)
  end
end
