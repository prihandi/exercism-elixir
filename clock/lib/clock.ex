defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: %Clock{}
  def new(h, m) do
    minute = Integer.mod(m, 60)
    hour = Integer.mod(Integer.floor_div(h * 60 + m, 60), 24)

    %Clock{hour: hour, minute: minute}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(%Clock{}, integer) :: %Clock{}
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: hour, minute: minute}),
    do: pad(hour) <> ":" <> pad(minute)

  defp pad(n), do: String.pad_leading("#{n}", 2, "00")
end
