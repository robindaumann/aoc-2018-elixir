defmodule Tree do
  defstruct children: [], meta: []

  @type t :: %Tree{children: [t], meta: [number()]}

  @spec leaf([number]) :: t
  def leaf(meta) do
    %Tree{children: [], meta: meta}
  end

  @spec node([t], [number]) :: t
  def node(children, meta) do
    %Tree{children: children, meta: meta}
  end

  @spec sum(t) :: number()
  def sum(%Tree{children: [], meta: meta}) do
    Enum.sum(meta)
  end

  def sum(%Tree{children: children, meta: meta}) do
    s = Enum.sum(meta)
    Enum.reduce(children, s, fn x, acc -> sum(x) + acc end)
  end

  @spec value(t) :: number()
  def value(%Tree{children: [], meta: meta}) do
    Enum.sum(meta)
  end

  def value(%Tree{children: children, meta: meta}) do
    meta
    |> Enum.reject(fn i -> i == 0 || i > length(children) end)
    |> Enum.map(fn i -> Enum.fetch!(children, i - 1) end)
    |> Enum.reduce(0, fn x, acc -> value(x) + acc end)
  end
end
