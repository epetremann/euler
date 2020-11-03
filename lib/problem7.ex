defmodule Problem7 do
  @moduledoc """
  https://projecteuler.net/problem=7

  
  """

  @doc """

  10_001 first prime
  
  By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that 
  the 6th prime is 13.

  What is the 10 001st prime number?


  """

  def first_prime(index_prime) do
    first_prime(index_prime-1, 3, [2])
  end
  defp first_prime(0, _n, [head | _tail]) do
    head
  end
  defp first_prime(index_prime, n,list) do
    if is_prime?(n,list) do
      first_prime(index_prime-1, n+2, [n | list])
    else
      first_prime(index_prime, n+2, list)
    end
  end
  defp is_prime?(_n, []) do
    true
  end
  defp is_prime?(n, [ head | tail]) do
    if rem(n,head) == 0 do
      false
    else
      is_prime?(n, tail)
    end
  end
  
end
