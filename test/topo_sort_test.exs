defmodule TopoSortTest do
  use ExUnit.Case
  doctest TopoSort

  test "empty graph" do
    digraph = :digraph.new()

    assert TopoSort.sort(digraph) == {:ok, []}
  end

  test "small" do
    digraph = :digraph.new()

    vertices = [:a, :b]
    [a,b] = for(v <- vertices, do: :digraph.add_vertex(digraph, v))

    :digraph.add_edge(digraph, a, b)

    assert TopoSort.sort(digraph) == {:ok, vertices}
  end

  test "medium" do
    digraph = :digraph.new()

    vertices = ["Unterhemd", "Pullover", "Unterhose", "Mantel", "Hose", "Schuhe", "Socken"]
    [unterhemd, pullover, unterhose, mantel, hose, schuhe, socken] = for(v <- vertices, do: :digraph.add_vertex(digraph, v))

    :digraph.add_edge(digraph, unterhemd, pullover)
    :digraph.add_edge(digraph, unterhose, hose)
    :digraph.add_edge(digraph, pullover, mantel)
    :digraph.add_edge(digraph, hose, mantel)
    :digraph.add_edge(digraph, hose, schuhe)
    :digraph.add_edge(digraph, socken, schuhe)

    {:ok, res} = TopoSort.sort(digraph)
    assert index(res, unterhemd) < index(res, pullover)
    assert index(res, unterhose) < index(res, hose)
    assert index(res, pullover) < index(res, mantel)
    assert index(res, hose) < index(res, schuhe)
    assert index(res, socken) < index(res, schuhe)
  end

  test "cyclic" do
    digraph = :digraph.new()

    vertices = [:a, :b]
    [a,b] = for(v <- vertices, do: :digraph.add_vertex(digraph, v))

    :digraph.add_edge(digraph, a, b)
    :digraph.add_edge(digraph, b, a)

    assert TopoSort.sort(digraph) == {:error, "Cycle detected!"}
  end

  test "cyclic raise" do
    digraph = :digraph.new()

    vertices = [:a, :b]
    [a,b] = for(v <- vertices, do: :digraph.add_vertex(digraph, v))

    :digraph.add_edge(digraph, a, b)
    :digraph.add_edge(digraph, b, a)

    assert_raise ArgumentError, fn ->
      TopoSort.sort!(digraph)
    end
  end

  test "with order" do
    digraph = :digraph.new()
    vertices = ["A", "B", "C", "D", "E", "F"]
    [a,b,c,d,e,f] = for(v <- vertices, do: :digraph.add_vertex(digraph, v))
    :digraph.add_edge(digraph, c, a)
    :digraph.add_edge(digraph, c, f)
    :digraph.add_edge(digraph, a, b)
    :digraph.add_edge(digraph, a, d)
    :digraph.add_edge(digraph, b, e)
    :digraph.add_edge(digraph, d, e)
    :digraph.add_edge(digraph, f, e)

    assert [c,a,b,d,f,e] ==TopoSort.sort!(digraph)
  end

  defp index(list, elem) do
    Enum.find_index(list, &(&1 == elem))
  end
end
