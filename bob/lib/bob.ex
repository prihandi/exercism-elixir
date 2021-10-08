defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      empty?(input) ->
        "Fine. Be that way!"

      yell?(input) && question?(input) ->
        "Calm down, I know what I'm doing!"

      question?(input) ->
        "Sure."

      yell?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  defp empty?(text), do: String.length(trim(text)) == 0
  defp question?(text), do: String.ends_with?(trim(text), "?")
  defp yell?(text), do: has_letters?(text) && all_caps?(text)
  defp has_letters?(text), do: Regex.match?(~r/\p{L}/, text)
  defp all_caps?(text), do: String.upcase(text) == text
  defp trim(text), do: String.trim(text)
end
