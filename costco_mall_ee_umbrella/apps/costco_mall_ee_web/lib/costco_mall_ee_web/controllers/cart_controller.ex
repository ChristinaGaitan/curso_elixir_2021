defmodule CostcoMallEeWeb.CartController do
  use CostcoMallEeWeb, :controller

  alias CostcoMallEe.Mall
  alias CostcoMallEe.Mall.Cart

  action_fallback CostcoMallEeWeb.FallbackController

  def index(conn, %{"count_gt" => count_gt, "total_gt" => total_gt}) do
    carts = Mall.get_carts_count_total!(String.to_integer(count_gt), String.to_integer(total_gt))
    render(conn, "index.json", carts: carts)
  end

  def index(conn, %{"count_gt" => count_gt}) do
    carts = Mall.get_carts_count!(String.to_integer(count_gt))
    render(conn, "index.json", carts: carts)
  end

  def index(conn, %{"total_gt" => total_gt}) do
    carts = Mall.get_carts_total!(String.to_integer(total_gt))
    render(conn, "index.json", carts: carts)
  end

  def index(conn, _params) do
    carts = Mall.list_carts()
    render(conn, "index.json", carts: carts)
  end

  def create(conn, %{"cart" => cart_params}) do
    with {:ok, %Cart{} = cart} <- Mall.create_cart(cart_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cart_path(conn, :show, cart))
      |> render("show.json", cart: cart)
    end
  end

  def show(conn, %{"id" => id}) do
    cart = Mall.get_cart!(id)
    render(conn, "show.json", cart: cart)
  end

  # def count(conn, %{"gt" => gt}) do
  #   cart = Mall.get_cart!(id)
  #   render(conn, "index.json", cart: cart)
  # end

  # def total(conn, %{"gt" => gt}) do
  #   cart = Mall.get_cart!(id)
  #   render(conn, "index.json", cart: cart)
  # end

  # def count_and_total(conn, %{"id" => id}) do
  #   cart = Mall.get_cart!(id)
  #   render(conn, "index.json", cart: cart)
  # end

  def update(conn, %{"id" => id, "cart" => cart_params}) do
    cart = Mall.get_cart!(id)

    with {:ok, %Cart{} = cart} <- Mall.update_cart(cart, cart_params) do
      render(conn, "show.json", cart: cart)
    end
  end

  def delete(conn, %{"id" => id}) do
    cart = Mall.get_cart!(id)

    with {:ok, %Cart{}} <- Mall.delete_cart(cart) do
      send_resp(conn, :no_content, "")
    end
  end
end
