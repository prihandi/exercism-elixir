defmodule Change do
  @err_message "cannot change"
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    with {:ok, target, coins} <- validate_inputs(coins, target) do
      1..target
      |> Enum.reduce(%{0 => []}, &find_change_coins(&1, &2, coins))
      |> Map.get(target)
      |> case do
        nil -> {:error, @err_message}
        result -> {:ok, Enum.sort(result)}
      end
    end
  end

  defp validate_inputs(coins, target) do
    cond do
      target < 0 ->
        {:error, @err_message}

      Enum.find(coins, fn x -> x < 0 end) ->
        {:error, @err_message}

      target == 0 ->
        {:ok, []}

      target < Enum.min(coins) ->
        {:error, @err_message}

      true ->
        nominals =
          coins
          |> Enum.sort(:desc)
          |> Enum.reject(fn x -> x > target end)

        {:ok, target, nominals}
    end
  end

  defp find_change_coins(target, acc, coins) do
    coins
    |> Enum.filter(&acc[target - &1])
    |> Enum.map(&[&1 | acc[target - &1]])
    |> Enum.min_by(&length/1, fn -> nil end)
    |> (&Map.put(acc, target, &1)).()
  end
end
