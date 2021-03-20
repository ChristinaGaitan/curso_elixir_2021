defmodule Rectangle do
  def area({a,b}) do
    a * b
  end
end

# Este modulo solo tiene 1 funcion, el mismo nombre, misma aridad
defmodule Geometry do
  def area({:rectangle, a, b}) do
    a * b
  end

  def area({:square, a}) do
    a * a
  end

  def area({:circle, r}) do
    r * r * 3.14
  end

  # Este seria el default cuando llega un valor no aceptado por las demas funciones
  def area(unknown) do
    {:error, unknown}
  end
end

# El equivalente en otros lenguajes
defmodule Geometry do
  def area(valores) do
    case valores do
      {:rectangle, a, b} -> a * b
      {:square, a} -> a * a
      {:circle, r} -> r * r * 3.14
    end
  end
end

defmodule TestNum do
  def test(x) when is_number(x) and x < 0 do
    :negative
  end

  def test(0) do
    :zero
  end

  def test(x) when is_number(x) and x > 0 do
    :positive
  end
end
