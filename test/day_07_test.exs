defmodule AocDay07Test do
  use ExUnit.Case

  test "Full input" do
    File.stream!("input/day_07.txt")
    |> Enum.map(&Regex.scan(~r/ [A-Z] /, &1))
    |> Enum.map(&List.flatten/1)
    |> AocDay07.solve()
  end
end
