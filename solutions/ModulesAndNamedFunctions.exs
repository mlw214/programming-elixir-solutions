# Problem 2 solution:
#   iex ModulesAndNamedFunctions.exs
#   iex -> c "ModulesAndNamedFunctions.exs"

defmodule ModulesAndNamedFunctions do
  def double(n), do: n * 2

  # Problem 1.
  def triple(n), do: n * 3

  # Problem 3.
  def quadruple(n), do: double(double(n))

  # Problem 4.
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)

  # Problem 5.
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  # Problem 6.
  def guess(actual, range = low..high) when low < high do
    guess = div(low + high, 2)
    IO.puts("Is it #{guess}")
    do_guess(actual, guess, range)
  end
  defp do_guess(actual, guess, _..high) when guess < actual do
    guess(actual, guess+1..high)
  end
  defp do_guess(actual, guess, low.._) when guess > actual do
    guess(actual, low..guess-1)
  end
  defp do_guess(actual, actual, _) do
    IO.puts("It is #{actual}")
    actual
  end
end