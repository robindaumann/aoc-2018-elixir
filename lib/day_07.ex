defmodule Day07 do
  @moduledoc """
  Documentation for AocDay07.
  """

  def solve input do
    g = :digraph.new()

    # Build the graph
    Enum.each(input, fn [a,b | _] ->
      v1 = :digraph.add_vertex(g, a)
      v2 = :digraph.add_vertex(g, b)
      :digraph.add_edge(g, v1, v2)
    end)

    TopoSort.sort!(g)
    |> Enum.map(&String.trim/1)
    |> Enum.join
    |> IO.inspect
  end
end
