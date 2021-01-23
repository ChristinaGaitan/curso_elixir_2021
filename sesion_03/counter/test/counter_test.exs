defmodule CounterTest do
  use ExUnit.Case # Es el modulo para poder utilizar las pruebas
  doctest Counter # Especifica que en el modulo Counter hay mas pruebas definidas

  # Se utilizan macros, por eso no se utiliza def para definir esta función
  # Las macros son como los plugins para el compilador
  test "greets the world" do
    assert Counter.hello() == :world
  end
end
