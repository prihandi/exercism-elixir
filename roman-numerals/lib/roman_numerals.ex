defmodule RomanNumerals do
  @roman_m 1000
  @roman_cm 900
  @roman_d 500
  @roman_cd 400
  @roman_c 100
  @roman_xc 90
  @roman_l 50
  @roman_xl 40
  @roman_x 10
  @roman_ix 9
  @roman_v 5
  @roman_iv 4
  @roman_i 1

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(0), do: ""
  def numeral(x) when x >= @roman_m, do: "M" <> numeral(x - @roman_m)
  def numeral(x) when x >= @roman_cm, do: "CM" <> numeral(x - @roman_cm)
  def numeral(x) when x >= @roman_d, do: "D" <> numeral(x - @roman_d)
  def numeral(x) when x >= @roman_cd, do: "CD" <> numeral(x - @roman_cd)
  def numeral(x) when x >= @roman_c, do: "C" <> numeral(x - @roman_c)
  def numeral(x) when x >= @roman_xc, do: "XC" <> numeral(x - @roman_xc)
  def numeral(x) when x >= @roman_l, do: "L" <> numeral(x - @roman_l)
  def numeral(x) when x >= @roman_xl, do: "XL" <> numeral(x - @roman_xl)
  def numeral(x) when x >= @roman_x, do: "X" <> numeral(x - @roman_x)
  def numeral(x) when x >= @roman_ix, do: "IX" <> numeral(x - @roman_ix)
  def numeral(x) when x >= @roman_v, do: "V" <> numeral(x - @roman_v)
  def numeral(x) when x >= @roman_iv, do: "IV" <> numeral(x - @roman_iv)
  def numeral(x), do: "I" <> numeral(x - @roman_i)
end
