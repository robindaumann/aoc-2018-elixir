defmodule AocDay08Test do
  use ExUnit.Case, async: true

  test "Solve part 1 full" do
    path = "input/day_08.txt"
    assert Day08.part1(path) == {:ok, 49180}
  end

  test "Solve part 1 example" do
    path = "input/day_08.example.txt"
    assert Day08.part1(path) == {:ok, 138}
  end

  test "Solve part 2 full" do
    path = "input/day_08.txt"
    assert Day08.part2(path) == {:ok, 999}
  end

  test "Solve part 2 example" do
    path = "input/day_08.example.txt"
    assert Day08.part2(path) == {:ok, 66}
  end
end
