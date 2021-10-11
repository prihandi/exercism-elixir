defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(fn
      "#######" <> rest -> "<p>########{rest}</p>"
      "#" <> rest -> parse_header(rest, 1)
      "* " <> rest -> "<li>#{rest}</li>"
      rest -> "<p>#{rest}</p>"
    end)
    |> replace_md
  end

  defp parse_header(" " <> rest, acc), do: "<h#{acc}>#{rest}</h#{acc}>"
  defp parse_header("#" <> rest, acc), do: parse_header(rest, acc + 1)

  defp replace_md(m) do
    m
    |> String.replace(~r/__(.*?)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.*?)_/, "<em>\\1</em>")
    |> String.replace(~r/<li>.*<\/li>/, "<ul>\\0</ul>")
  end
end
