defmodule Day10 do
  def solve(path) do
    path
    |> File.stream!()
    |> Enum.map(&Regex.scan(~r/-?\d+/, &1))
    |> Enum.map(&List.flatten/1)
    |> Enum.map(fn l -> Enum.map(l, &String.to_integer/1) end)
    |> Grid.grid()
    |> simulate
    |> Grid.display()

    :done
  end

  def simulate(grid) do
    grid = Grid.step(grid)

    case grid do
      {:ok, grid} -> simulate(grid)
      {:stop, grid} -> grid
    end
  end
end
