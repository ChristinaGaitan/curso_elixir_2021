defmodule Counter do
  # Hay que evitar lo más posible el uso de imports
  # import String

  # Si empiezan con @ son atributos de código (NO son variables)
  # Son metadatos asociados al modulo

  @moduledoc """
  Documentation for `Counter`.
  """

  # El ejemplo se convirte en una prueba
  @doc """
  Hello world.

  ## Examples

      iex> Counter.hello()
      :world

  """
  def hello do
    :world
  end

  # Funcion principal
  # El _ junto args es para evitar warnings
  # Para crear el binario: mix escript.build
  def main(_args) do
    {:ok, result} = count_lines()
    IO.puts result
  end

  @doc """
  Counts lines.

  ## Examples

      iex> Counter.count_lines("words")
      {:ok, 235886}

  """
  # Cargar la iex con el modulo: iex -S mix
  # Counter.count_lines("words") encuentra el archivo
  # porque esta en el directorio raiz
  # Parametros opcionales con \\
  def count_lines(file_name \\ "words") do
    # Se pueden hacer imports dentro de la funcion
    # import String
    num_lines = File.read!(file_name)
    |> String.split()
    |> Enum.count()

    {:ok, num_lines}
  end


  def count_binary(file_name) do
    content = File.read!(file_name)
    hash = :crypto.hash(:md5, content)

    {:ok, byte_size(hash)}
  end
end


# Ejemplo para procesos
defmodule HelloWorld do
  def greet do
    IO.puts "hello"
  end
end

# Ejemplo para procesos que solo termina cuando se cumple el pattern matching
# defmodule HelloWorldServer do
#   def greet do
#     receive do
#       # Hace que el proceso quede en espera
#       {sender, msg} -> send(sender, {:ok, "Hello, #{msg}"})
#     end
#   end
# end

 # Hacerlo ciclico con recursividad
defmodule HelloWorldServer do
  def greet do
    receive do
      # Hace que el proceso quede en espera
      {sender, msg} -> send(sender, {:ok, "Hello, #{msg}"})
    end
    greet() # Hacerlo ciclico con recursividad
  end
end


sync_query = fn(query_def) ->
  :timer.sleep(2000)
  "#{query_def} result"
end

async_query = fn(query_def) ->
  spawn(fn -> IO.puts(sync_query.(query_def)) end)
end

async_query = fn(query_def) ->
  # Este código se ejecuta en el proceso del shell
  caller = self() # es una función que devuelve el id del proceso en donde se ejecuta el código

  # El cóido dentro del spawn es el código que se ejecuta en el nuevo proceso
  spawn(fn ->
    send(caller, {:query_result, sync_query.(query_def)})
   end)
end

get_result = fn ->
  receive do
    {:query_result, result} -> result
  end
end

1..5 |>
 Enum.map(&async_query.("query #{&1}")) |>
 Enum.map(fn(_) -> get_result.() end)

# ===============================
async_queries = fn(queries) ->
  queries |>
  Enum.map(&async_query.("query #{&1}")) |>
  Enum.map(fn(_) -> get_result.() end)
end
