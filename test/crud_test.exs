defmodule CrudTest do
  use ExUnit.Case
  doctest Crud

  test "greets the world" do
    assert Crud.hello() == :world
  end
end
