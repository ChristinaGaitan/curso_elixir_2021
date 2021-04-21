defmodule ShoppingMallWeb.CartController do
  use ShoppingMallWeb, :controller
  alias ShoppingMall.CartAgent

  def index(conn, _params) do
    cart = CartAgent.value()
    render(conn, "cart_index.html", cart: cart)
  end

  def update(conn, %{"action" => action} = params) when action == "add" do
    CartAgent.increment()

    conn
      |> redirect(to: "/cart")
  end

  def update(conn, %{"action" => action} = params) when action == "discount" do
    CartAgent.decrement()

    conn
      |> redirect(to: "/cart")
  end

  def update(conn, params) do
    conn
      |> redirect(to: "/cart")
  end
end
