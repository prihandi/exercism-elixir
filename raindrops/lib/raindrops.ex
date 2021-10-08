defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    case {pling?(number), plang?(number), plong?(number)} do
      {true, true, true} -> "PlingPlangPlong"
      {true, true, _} -> "PlingPlang"
      {true, _, true} -> "PlingPlong"
      {_, true, true} -> "PlangPlong"
      {true, _, _} -> "Pling"
      {_, true, _} -> "Plang"
      {_, _, true} -> "Plong"
      _-> "#{number}"

    end
  end

  defp pling?(n), do: rem(n, 3) == 0

  defp plang?(n), do: rem(n, 5) == 0

  defp plong?(n), do: rem(n, 7) == 0
end
