defmodule Problem9 do
  @moduledoc """
  https://projecteuler.net/problem=9

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
    pythagorian_triplet(div(n,2)-1, 1, n) 
  end
  defp pythagorian_triplet(a, _b, _n) when a <= 0 do
    nil
  end
  defp pythagorian_triplet(a, b, n) when b >= a do
    pythagorian_triplet(a-1, 1, n) 
  end

  defp pythagorian_triplet(a, b, n) when (a*a + b*b == (n-a-b)*(n-a-b)) do
    c=1000-a-b
    {a*b*c, a,b,c}
  end
  defp pythagorian_triplet(a, b, n) do
    pythagorian_triplet(a, b+1, n) 
  end


  
end
