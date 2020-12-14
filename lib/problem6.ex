defmodule Euler.Problem6 do
  @moduledoc """
  https://projecteuler.net/problem=6

  Sum Square difference


  The sum of the squares of the first ten natural numbers is,
  1*1 + 2*2 + 3*3 ... + 10*10 = 385

  The square of the sum of the first ten natural numbers is,
  ( 1 + 2 + 3 +  ... + 10) * ( 1 + 2 + 3 ... + 10 ) = 3025

  Hence the difference between the sum of the squares of the first ten natural numbers and the 
  square of the sum is
  3025 - 385 = 2640


  Find the difference between the sum of the squares of the first one hundred natural numbers 
  and the square of the sum.

  """

  defp diff_sum_squares(n, squares, sum) when n <= 0 do
    sum * sum - squares
  end

  defp diff_sum_squares(n, squares, sum) do
    diff_sum_squares(n - 1, squares + n * n, sum + n)
  end

  def diff_sum_squares(n) do
    diff_sum_squares(n, 0, 0)
  end
end
