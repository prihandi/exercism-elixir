defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(n) do
    """
    #{get_bottles(n)} of beer on the wall, #{get_bottles_mid(n)} of beer.
    #{get_action_phrase(n)}, #{get_bottles_mid(n - 1)} of beer on the wall.
    """
  end

  defp get_bottles(-1), do: get_bottles(99)
  defp get_bottles(0), do: "No more bottles"
  defp get_bottles(1), do: "1 bottle"
  defp get_bottles(n), do: "#{n} bottles"

  defp get_bottles_mid(0), do: String.downcase(get_bottles(0))
  defp get_bottles_mid(n), do: get_bottles(n)

  defp get_action_phrase(0), do: "Go to the store and buy some more"
  defp get_action_phrase(1), do: "Take it down and pass it around"
  defp get_action_phrase(n), do: "Take one down and pass it around"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
   range
   |> Enum.map(&verse(&1))
   |> Enum.join("\n")
  end
end
