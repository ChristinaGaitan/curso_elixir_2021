# Es convención utilizar el operador pipe al inicio
# La ultima linea de la funcion es el valor de return
# Para correrlo desde la terminal:
# elixir counter.exs

defmodule Counter do
  def count_lines do
    File.read!("words")
    |> String.split()
    |> Enum.count()
  end
end

IO.puts(Counter.count_lines)
