# Chapter 5.
defmodule AssertError do
  defexception [:message]
end

defmodule AnonymousFunctions do
  defp assert(predicate, success_msg, fail_msg) do
    if predicate do
      IO.puts(success_msg)
    else
      raise AssertError, message: fail_msg
    end
  end

  def problem1() do
    list_concat = fn (x, y) -> x ++ y end
    assert(
      list_concat.([:a, :b], [:c, :d]) == [:a, :b, :c, :d],
      "list_concat.([:a, :b], [:c, :d]) == [:a, :b, :c, :d]",
      "Expected list_concat.([:a, :b], [:c, :d]) == [:a, :b, :c, :d]"
    )

    sum = fn (x, y, z) -> x + y + z end
    assert(sum.(1, 2, 3) == 6, "sum.(1, 2, 3) == 6", "Expected sum.(1, 2, 3) == 6")

    pair_tuple_to_list = fn ({x, y}) -> [x, y] end
    assert(
      pair_tuple_to_list.({1234, 5678}) == [1234, 5678],
      "pair_tuple_to_list.({1234, 5678}) == [1234, 5678]",
      "Expected pair_tuple_to_list.({1234, 5678}) == [1234, 5678]"
    )
  end

  def problems2and3() do
    fizzbuzz = fn
      (0, 0, _) -> "FizzBuzz"
      (0, _, _) -> "Fizz"
      (_, 0, _) -> "Buzz"
      (_, _, x) -> x
    end
    
    fb = fn (n) -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end
    actual = "#{fb.(10)}, #{fb.(11)}, #{fb.(12)}, #{fb.(13)}, #{fb.(14)}, #{fb.(15)}, #{fb.(16)}"
    expected = "Buzz, 11, Fizz, 13, 14, FizzBuzz, 16"
    assert(actual == expected, actual, "Expected #{expected}")
  end

  def problem4() do
    prefix = fn (s1) -> (fn (s2) -> "#{s1} #{s2}" end) end

    mrs = prefix.("Mrs")
    actual = mrs.("Smith")
    expected = "Mrs Smith"
    assert(actual == expected, actual, "Expected #{expected}")

    actual = prefix.("Elixir").("Rocks")
    expected = "Elixir Rocks"
    assert(actual == expected, actual, "Expected #{expected}")
  end

  def problem5() do
    actual = Enum.map([1, 2, 3, 4], &(&1 + 2))
    expected = [3, 4, 5, 6]
    assert(
      actual == expected,
      "Enum.map([1, 2, 3, 4], &(&1 + 2)) == [3, 4, 5, 6]",
      "Expected Enum.map([1, 2, 3, 4], &(&1 + 2)) == [3, 4, 5, 6]"
    )

    Enum.each([1, 2, 3, 4], &IO.inspect/1)
  end
end