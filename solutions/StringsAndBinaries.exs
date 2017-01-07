defmodule StringsAndBinaries do
  def is_printable?(str) do
    Enum.all?(str, &(&1 >= 32 && &1 < 127))
  end

  def anagram?(word1, word2) do
    if length(word1) != length(word2) do
      false
    end
    Enum.all?(word1, &(&1 in word2))
  end

  def calculate(expression) do
    parse(expression, 0)
  end
  defp parse([], value) do
    value
  end
  defp parse([?\s | tail], value) do
    parse(tail, value)
  end
  defp parse([?+ | tail], value) do
    value + parse(tail, 0)
  end
  defp parse([?- | tail], value) do
    value - parse(tail, 0)
  end
  defp parse([?* | tail], value) do
    value * parse(tail, 0)
  end
  defp parse([?/ | tail], value) do
    value / parse(tail, 0)
  end
  defp parse([digit | tail], value) when digit in '0123456789' do
    parse(tail, value * 10 + digit - ?0)
  end
  defp parse([non_digit | _], _) do
    raise "Invalid character #{non_digit}"
  end

  def center(strs) do
    longest = strs |> Enum.max_by(&String.length/1) |> String.length
    Enum.each(strs, fn (str) ->
      len = String.length(str)
      num = longest - len
      nleft = div(num, 2)
      nright = div(num, 2) + rem(num, 2)
      str
      |> String.pad_leading(len + nleft)
      |> String.pad_trailing(len + nleft + nright)
      |> IO.puts
    end)
  end

  def capitalize_sentences(str) do
    str
    |> String.split(~r{\.\s+})
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join(". ")
  end

  def calculate_sales_tax() do
    File.open("./fixtures/shipments.txt", [:read], fn (file) ->
      keys = IO.read(file, :line)
      |> String.split(~r/,/)
      |> Enum.map(&(String.trim(&1)))
      |> Enum.map(&String.to_atom/1)

      IO.stream(file, :line)
      |> Stream.map(&String.split(&1, ~r/,/))
      |> Stream.map(fn (line) -> Enum.map(line, &parse/1) end)
      |> Stream.map(&(Enum.zip(keys, &1)))
      |> do_calculate_sales_tax
    end)
  end

  defp parse(str) do
    str = String.trim(str)
    cond do
      Regex.match?(~r/^\d+$/, str) -> String.to_integer(str)
      Regex.match?(~r/^\d+\.\d+$/, str) -> String.to_float(str)
      String.starts_with?(str, ":") ->
        str |> String.slice(1, String.length(str) - 1) |> String.to_atom
      true -> str
    end
  end

  defp do_calculate_sales_tax(orders) do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    states = Dict.keys(tax_rates)
    for order = [id: _, ship_to: dest, net_amount: price] <- orders do
      if dest in states do
        Keyword.put(order, :total_amount, price + price * tax_rates[dest])
      else
        Keyword.put(order, :total_amount, price)
      end
    end
  end
end