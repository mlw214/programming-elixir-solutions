defmodule ListsAndRecursion do
  # Problem 1.
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  # Problem 2.
  def mapsum([], _), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

  # Problem 3 - taken to the extreme!
  defmodule Caeser do
    def encrypt([], _), do: []
    def encrypt([head | tail], n)
      when head < ?A or (head > ?Z and head < ?a) or head > ?z,
      do: [head | encrypt(tail, n)]
    def encrypt([head | tail ], n)
      when head+n <= ?Z or (head >= ?a and head+n <= ?z),
      do: [head+n | encrypt(tail, n)]
    def encrypt([head | tail], n), do: [head+n-26 | encrypt(tail, n)]

    def decrypt([], _), do: []
    def decrypt([head | tail], n)
      when head < ?A or (head > ?Z and head < ?a) or head > ?z,
      do: [head | decrypt(tail, n)]
    def decrypt([head | tail], n)
      when (head <= ?Z and head-n >= ?A) or head-n >= ?a,
      do: [head-n | decrypt(tail, n)]
    def decrypt([head | tail], n), do: [head-n+26 | decrypt(tail, n)]
  end

  # Problem 4.
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from+1, to)]
end