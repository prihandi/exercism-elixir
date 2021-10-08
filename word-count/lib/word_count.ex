defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """

  @word_splitter ~R/[^[:alnum:]\-\']/u

  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(@word_splitter, trim: true)
    # remove quote on quoted words
    |> Enum.map(&String.trim(&1, "'"))
    |> Enum.reduce(Map.new(), fn word, result ->
      Map.update(result, word, 1, &(&1 + 1))
    end)
  end
end
