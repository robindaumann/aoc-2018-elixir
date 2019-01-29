defmodule Day07 do
  @moduledoc """
  Documentation for AocDay07.
  """

  def solve(path) do
    path
    |> File.stream!
    |> Enum.map(&Regex.scan(~r/ [A-Z] /, &1))
    |> Enum.map(&List.flatten/1)
    |> Enum.map(fn [a,b] -> [String.trim(a), String.trim(b)] end)
    |> parse
  end

  def parse(input) do
    graph = :digraph.new()

    # Build the graph
    Enum.each(input, fn [a,b | _] ->
      v1 = :digraph.add_vertex(graph, a)
      v2 = :digraph.add_vertex(graph, b)
      :digraph.add_edge(graph, v1, v2)
    end)

    graph
    |> TopoSort.sort!
    |> Enum.join
  end
end
