defmodule Grid do
  defstruct points: [], yrange: :infinity, steps: 0

  def grid(points) do
    %Grid{points: points}
  end

  def step(grid) do
    points = Enum.map(grid.points, fn [x, y, dx, dy] -> [x + dx, y + dy, dx, dy] end)
    prev_yrange = grid.yrange

    {min_y, max_y} = min_max(points, :y)
    yrange = max_y - min_y

    if yrange > prev_yrange do
      {:stop, grid}
    else
      {:ok, %{grid | points: points, yrange: yrange, steps: grid.steps+1}}
    end
  end

  def display(grid) do
    m = MapSet.new(grid.points, &Enum.slice(&1, 0..1))

    {min_x, max_x} = min_max(m, :x)
    {min_y, max_y} = min_max(m, :y)

    Enum.each(min_y..max_y, fn y ->
      Enum.each(min_x..max_x, fn x ->
        IO.write(if MapSet.member?(m, [x, y]), do: '#', else: '.')
      end)

      IO.puts("")
    end)

    IO.puts("Steps #{grid.steps}")
  end

  defp min_max(set, dir) do
    i =
      case dir do
        :x -> 0
        :y -> 1
      end

    set
    |> Enum.map(&Enum.at(&1, i))
    |> Enum.min_max()
  end
end
