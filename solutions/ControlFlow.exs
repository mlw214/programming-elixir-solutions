defmodule ControlFlow do
  def fizzbuzz_upto(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end
  defp fizzbuzz(n) do
    case { rem(n, 3), rem(n, 5) } do
      { 0, 0 } -> "FizzBuzz"
      { 0, _ } -> "Fizz"
      { _, 0 } -> "Buzz"
      _ -> n
    end
  end

  def ok!(result) do
    case result do
      { :ok, data } -> data
      { type, message } -> raise("#{type}: #{message}")
    end
  end
end