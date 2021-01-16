# Es convención utilizar el operador pipe al inicio
# Para correrlo desde la terminal
# elixir counter.exs

defmodule Counter do
  def count_lines do
    num_lines = File.read!("words")
    |> String.split()
    |> Enum.count()

    num_lines
  end
end

IO.puts(Counter.count_lines)
