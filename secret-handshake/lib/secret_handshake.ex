defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @conversions [
    {0b1, "wink"},
    {0b10, "double blink"},
    {0b100, "close your eyes"},
    {0b1000, "jump"},
    {0b10000, :reverse}
  ]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> convert()
    |> maybe_reverse()
  end

  defp convert(code) do
    @conversions
    |> Enum.reduce([], fn {value, action}, acc ->
      if (code &&& value) > 0 do
        [action | acc]
      else
        acc
      end
    end)
  end

  defp maybe_reverse([:reverse | tail]), do: tail
  defp maybe_reverse(list), do: Enum.reverse(list)
end
