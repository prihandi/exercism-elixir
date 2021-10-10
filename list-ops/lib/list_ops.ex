defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list), do: foldl(list, 0, fn _, acc -> acc + 1 end)

  @spec reverse(list) :: list
  def reverse(list), do: foldl(list, [], &[&1 | &2])

  @spec map(list, (any -> any)) :: list
  def map(list, fun), do: foldr(list, [], &[fun.(&1) | &2])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, fun) do
    foldr(list, [], fn elem, acc ->
      if fun.(elem) do
        [elem | acc]
      else
        acc
      end
    end)
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _), do: acc
  def foldl([head | tail], acc, fun), do: foldl(tail, fun.(head, acc), fun)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(list, acc, fun) do
    list
    |> reverse()
    |> foldl(acc, fun)
  end

  @spec append(list, list) :: list
  def append(a, b), do: foldr(a, b, &[&1 | &2])

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    foldr(ll, [], fn list, acc ->
      foldr(list, acc, &[&1 | &2])
    end)
  end
end
