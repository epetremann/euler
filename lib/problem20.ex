defmodule Problem20 do

  @moduledoc """
  https://projecteuler.net/problem=20

  Factorial digit sum


  

  n! means n × (n − 1) × ... × 3 × 2 × 1

  For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
  and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

  Find the sum of the digits in the number 100!

  """

  @doc """
  Calculates the sum of the digits of n! (factorial)

  """
  def factorial_digit_sum(n) do
    fact(n)                 # Calculate !n
    |> Integer.to_charlist  # convert to list of char
    |> Enum.map(&(&1-?0))   # convert each element to digit value
    |> Enum.sum             # sum all elements
  end   
  defp fact(1), do: 1
  defp fact(n), do: n*fact(n-1)

end # module
