defmodule Counter do
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

  def count_lines(file_name) do
    num_lines = File.read!(file_name)
    |> String.split()
    |> Enum.count()

    {:ok, num_lines}
  end

  # Cargar la iex con el modulo: iex -S mix
end
