defmodule ElixirFizzbuzz do
  @moduledoc """
  Classic FizzBuzz.
  """
  @doc """
  Returns a joined binary of FizzBuzz up to a given limit.

  ## Examples

      iex> ElixirFizzbuzz.run(16)
      "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16"
  """
  def run(upper_limit \\ 100) do
    1..upper_limit
    |> Stream.map(&fizz/1)
    |> Enum.join(" ")
  end

  defp fizz(num) when rem(num, 15) == 0, do: "FizzBuzz"
  defp fizz(num) when rem(num, 5) == 0, do: "Buzz"
  defp fizz(num) when rem(num, 3) == 0, do: "Fizz"
  defp fizz(num), do: num
end
