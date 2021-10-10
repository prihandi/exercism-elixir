defmodule Gigasecond do
  @seconds_to_add 1_000_000_000
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, date} = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
    dest_date = NaiveDateTime.add(date, @seconds_to_add, :second)

    {{dest_date.year, dest_date.month, dest_date.day},
     {dest_date.hour, dest_date.minute, dest_date.second}}
  end
end
