defmodule Day10 do
  def solve(path) do
    path
    |> File.stream!
    |> Enum.map(&Regex.scan(~r/-?[0-9]+/, &1))
    |> Enum.map(&List.flatten/1)
    |> Enum.map(fn l -> Enum.map(l, &String.to_integer/1) end)
    |> IO.inspect

    0
  end
end
