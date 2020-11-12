defmodule Problem27 do
  @moduledoc """
  https://projecteuler.net/problem=27

  Quadratic primes

  Euler discovered the remarkable quadratic formula:

  It turns out that the formula will produce 40 primes for the consecutive integer values
  . However, when is divisible by 41, and certainly when

  is clearly divisible by 41.

  The incredible formula
  was discovered, which produces 80 primes for the consecutive values

  . The product of the coefficients, −79 and 1601, is −126479.

  Considering quadratics of the form:

  , where and

  where
  is the modulus/absolute value of
  e.g. and

  Find the product of the coefficients,
  and , for the quadratic expression that produces the maximum number of primes for
  consecutive values of n starting with n=0.
  
  """

  def quadratic_primes(min \\ 19) do
    for a <- -999..999, b <- -1000..1000 do
        {a*b, a, b, number_of_consecutive_primes(a,b,1) } 
    end |> Enum.filter(fn {_,_,_,n} -> n > min end)
  end

  def number_of_consecutive_primes(a,b,n) do
    candidate = abs(n*n + a*n + b)
    if candidate >=3 and is_prime?(candidate) do
       number_of_consecutive_primes(a,b, n+1)
    else
      n
    end #if
  end #number_of_consecutive_primes
  


  defp is_prime?(n) do
    max_factor = n |> :math.sqrt |> floor
    is_prime?(n, 3, max_factor)
  end
  defp is_prime?(_n, factor, max_factor) when factor > max_factor do
    true
  end
  defp is_prime?(n, factor, max_factor) do
    if rem(n, factor) == 0 do
      false
    else
      is_prime?(n, factor+2, max_factor)
    end
  end
  
end
