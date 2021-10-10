defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(h, m) do
    minute = rem(m, 60)
    hour = rem(h + div(m, 60), 24)

    {final_hour, final_minute} =
      case {hour < 0, minute < 0, hour == 0} do
        {true, true, _} -> {23 + hour, 60 + minute}
        {_, true, true} -> {23, 60 + minute}
        {_, true, _} -> {hour - 1, 60 + minute}
        {true, _, _} -> {24 + hour, minute}
        _ -> {hour, minute}
      end

    %Clock{hour: final_hour, minute: final_minute}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: hour, minute: minute}),
    do: pad(hour) <> ":" <> pad(minute)

  defp pad(n), do: String.pad_leading("#{n}", 2, "00")
end
