defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    list
    |> flatten_list()
    |> Enum.reject(&is_nil(&1))
  end

  def flatten_list([]), do: []

  def flatten_list([head | tail]) when is_list(head) do
    flatten_list(flatten_list(head) ++ tail)
  end

  def flatten_list([head | tail]), do: [head | flatten(tail)]
end
