defmodule Day10Test do
  use ExUnit.Case

  test "Part 1 full input" do
    assert Day10.solve("input/day_10.txt") == :done
  end

  test "Part 1 example input" do
    assert Day10.solve("input/day_10.example.txt") == :done
  end
end
