defmodule Problem10_2 do
  @moduledoc """
  https://projecteuler.net/problem=10

  Summation of primes

  The sum of prime numbers below ten is :
  2 + 3 + 5 + 7 = 17

  Find the sum of primes below two million

  
  """

  @doc """


  """

  def sum_of_primes_below(big_number \\ 2_000_000) do
    n = big_number + rem(big_number, 2) - 1
    sum_of_primes_below(2, n)
  end
  defp sum_of_primes_below(sum, n) when n < 2 do
    sum
  end
  defp sum_of_primes_below(sum, n) do
    # IO.inspect({:sum_of_primes_below, n<2, sum, n})
    if is_prime?(n) do
      IO.inspect {:sum, sum, :n, n}
      sum_of_primes_below(sum+n, n-2)
    else
      sum_of_primes_below(sum, n-2)
    end
  end
  defp is_prime?(n) do
    max_factor = n |> :math.sqrt |> floor
    # IO.inspect { :is_prime_1, :n, n, :max_factor, max_factor }
    is_prime?(n, 3, max_factor)
  end
  defp is_prime?(_n, factor, max_factor) when factor > max_factor do
    # IO.inspect {:is_prime, factor > max_factor, n, factor, max_factor, rem(n,factor) }
    true
  end
  defp is_prime?(n, factor, max_factor) do
    # IO.inspect {:is_prime, factor > max_factor, n, factor, max_factor, rem(n,factor) }
    if rem(n, factor) == 0 do
      false
    else
      is_prime?(n, factor+2, max_factor)
    end
  end
  
end
