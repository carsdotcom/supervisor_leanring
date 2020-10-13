defmodule SimpleCounterTest do
  use ExUnit.Case
  doctest SimpleCounter

  test "greets the world" do
    assert SimpleCounter.hello() == :world
  end
end
