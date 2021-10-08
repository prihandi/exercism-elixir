defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """

  @alphanum_splitter ~R/[^[:alnum:]\-]/u

  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(@alphanum_splitter, trim: true)
    |> Enum.reduce(Map.new(), fn word, result ->
      Map.update(result, word, 1, &(&1 + 1))
    end)
  end
end
