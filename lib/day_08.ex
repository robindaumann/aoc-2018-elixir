defmodule Day08 do
  def part1(path) do
    solve(path, &Tree.sum/1)
  end

  def part2(path) do
    solve(path, &Tree.value/1)
  end

  def solve(path, aggregator) do
    res = path
    |> File.read!
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> parse_node

    case res do
      {[], tree} -> {:ok, aggregator.(tree)}
      _ -> {:error, "Bad format."}
    end
  end

  defp parse_node([0, meta | tail]) do
    {meta, l} = Enum.split(tail, meta)
    {l, Tree.leaf(meta)}
  end

  defp parse_node([nodes, meta | tail]) do
    {l, children} = parse_children(tail, nodes, [])
    {meta, l} = Enum.split(l, meta)
    {l, Tree.node(children, meta)}
  end

  defp parse_children(l, 0, children) do
    {l, Enum.reverse(children)}
  end

  defp parse_children(l, num, children) do
    {l, child} = parse_node(l)
    parse_children(l, num-1, [child | children])
  end
end
