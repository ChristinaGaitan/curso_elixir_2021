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
    IO.puts count_lines()
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
