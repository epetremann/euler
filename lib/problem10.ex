defmodule Problem10 do
  @moduledoc """
  https://projecteuler.net/problem=10

  Special Pythagorian triplet



  A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
  a2 + b2 = c2

  For example, 32 + 42 = 9 + 16 = 25 = 52.

  There exists exactly one Pythagorean triplet for which a + b + c = 1000.
  Find the product abc.

  
  """

  @doc """


  """

  def pythagorian_triplet(n \\ 1000) do
    for a <- 1..(div(n,2)-1), do
      for b <- (n-1)..(a+1), (a*a + b*b == (n-a-b)*(n-a-b))
    end
  end
  
end
