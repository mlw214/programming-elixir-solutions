defmodule ProcessingCollections do
  Code.require_file("ListsAndRecursion.exs", __DIR__)

  def all?([], _) do
    true
  end
  def all?([head | tail], pred) do
    if pred.(head) do
      all?(tail, pred)
    else
      false
    end
  end

  def each([], _) do
    :ok
  end
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  # Get a little tail recursion going.
  def filter(list, func) do
    do_filter(list, [], func)
  end
  defp do_filter([], acc, _) do
    Enum.reverse(acc)
  end
  defp do_filter([head | tail], acc, pred) do
    if pred.(head) do
      do_filter(tail, [head | acc], pred)
    else
      do_filter(tail, acc, pred)
    end
  end

  def split(list, n) do
    do_split(list, [], n)
  end
  defp do_split([], front, _) do
    {Enum.reverse(front), []}
  end
  defp do_split(tail, front, 0) do
    {Enum.reverse(front), tail}
  end
  defp do_split([head | tail], front, n) do
    do_split(tail, [head | front], n-1)
  end

  def take(list, count), do: elem(split(list, count), 0)

  def flatten([]), do: []
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
  def flatten(head), do: [head]

  def primes(n) do
    range = ListsAndRecursion.span(2, n)
    sieve = for a <- range, b <- range, a <= b, a * b <= n, do: a * b
    range -- sieve
  end

  def calculate_total_amount() do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    orders = [
      [id: 123, ship_to: :NC, net_amount: 100.00],
      [id: 124, ship_to: :OK, net_amount:  35.50],
      [id: 125, ship_to: :TX, net_amount:  24.00],
      [id: 126, ship_to: :TX, net_amount:  44.80],
      [id: 127, ship_to: :NC, net_amount:  25.00],
      [id: 128, ship_to: :MA, net_amount:  10.00],
      [id: 129, ship_to: :CA, net_amount: 102.00],
      [id: 120, ship_to: :NC, net_amount:  50.00]
    ]
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