defmodule CursoAppTest do
  use ExUnit.Case
  doctest CursoApp

  test "greets the world" do
    assert CursoApp.hello() == :world
  end
end
