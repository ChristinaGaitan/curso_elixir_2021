defmodule CryptoApiWeb.CurrencyController do
  # Tiene todas las funciones necesarias para que este controlador
  # se convierta en un controlador de phoenix
  use CryptoApiWeb, :controller

  # Toda función de controlador recibe esos 2 parametros
  # curl --location --request GET 'http://localhost:4000/api/currency'

  def index(conn, _params) do
    # new_conn = put_status(conn, 200)
    # new_conn_2 = text(new_conn, "Currency")
    # new_conn_2

    # Responde con texto
    # conn
    #   |> put_status(200)
    #   |> text("Currency")

    # Responde con json
    conn
      |> put_status(200)
      |> json(%{response: "Success"})

  end
end
