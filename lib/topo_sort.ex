defmodule TopoSort do
  @moduledoc """
  Documentation for TopoSort.
  """

  @spec sort!(:digraph.graph()) :: [any()]
  def sort!(graph) do
    case sort(graph) do
      {:ok, res} -> res
      {:error, reason} -> raise ArgumentError, message: reason
    end
  end

  @spec sort(:digraph.graph()) :: {:error, <<_::120>>} | {:ok, [any()]}
  def sort(graph) do
    vertices = Enum.filter(:digraph.vertices(graph), &no_incoming(graph,&1))
    sort_int(graph, [], vertices)
  end

  defp sort_int(graph, res, []) do
    case :digraph.edges(graph) do
      [] -> {:ok, Enum.reverse(res)}
      _ -> {:error, "Cycle detected!"}
    end
  end

  defp sort_int(graph, res, vertices) do
    vert = Enum.min(vertices)
    vertices = List.delete(vertices, vert)

    edges = :digraph.out_edges(graph, vert)
    neighbours = :digraph.out_neighbours(graph, vert)

    Enum.each(edges, fn edge ->
      :digraph.del_edge(graph, edge)
    end)

    remaining = Enum.filter(neighbours, &no_incoming(graph,&1))
    sort_int(graph, [vert | res], vertices ++ remaining)
  end

  defp no_incoming(graph, v) do
    :digraph.in_degree(graph, v) == 0
  end
end
