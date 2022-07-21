defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    text = trim(input)

    cond do
      empty?(text) -> "Fine. Be that way!"
      yell?(text) && question?(text) -> "Calm down, I know what I'm doing!"
      question?(text) -> "Sure."
      yell?(text) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp trim(text), do: String.trim(text)
  defp empty?(text), do: String.length(text) == 0
  defp question?(text), do: String.ends_with?(text, "?")
  defp yell?(text), do: has_letters?(text) && all_caps?(text)
  defp has_letters?(text), do: Regex.match?(~r/\p{L}/, text)
  defp all_caps?(text), do: String.upcase(text) == text
end
