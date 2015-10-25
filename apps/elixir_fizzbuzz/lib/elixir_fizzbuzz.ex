defmodule ElixirFizzbuzz do
  def run(upper_limit \\ 100) do
    1..100
    |> Stream.map(&fizz/1)
    |> Enum.join(" ")
  end

  defp fizz(num) when rem(num, 15) == 0, do: "FizzBuzz"
  defp fizz(num) when rem(num, 5) == 0, do: "Buzz"
  defp fizz(num) when rem(num, 3) == 0, do: "Fizz"
  defp fizz(num), do: num
end
