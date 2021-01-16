# Es convención utilizar el operador pipe al inicio
# Para correrlo desde la terminal
# elixir counter.exs

num_lines = File.read!("words")
            |> String.split()
            |> Enum.count()

IO.puts(num_lines)
