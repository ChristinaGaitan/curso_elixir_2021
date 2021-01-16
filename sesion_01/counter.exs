# - Es convención utilizar el operador pipe al inicio
# - La ultima linea de la funcion es el valor de return
# - Se puede regresar una tupla
# - Para correrlo desde la terminal:
#     elixir counter.exs

defmodule Counter do
  def count_lines do
    num_lines = File.read!("words")
    |> String.split()
    |> Enum.count()

    {:ok, num_lines}
  end
end

IO.inspect(Counter.count_lines)
