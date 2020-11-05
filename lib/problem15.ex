defmodule Problem15 do
  @moduledoc """
  https://projecteuler.net/problem=15


  lattice path


  Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down,
  there are exactly 6 routes to the bottom right corner.



  How many such routes are there through a 20×20 grid?


  """

  @doc """


  """

  def factorial(n) when n <= 0 do
    1
  end
  def factorial(n) do
    Enum.reduce(1..n, 1, fn(x,acc) -> x*acc end)
  end
  def binomial_coefficient( n \\ 40, k \\ 20) do
    div(factorial(n), factorial(k)*factorial(k))
  end
end
