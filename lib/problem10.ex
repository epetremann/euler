defmodule Problem10 do
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
    sum_of_primes_below(3, [2], big_number)
  end
  defp sum_of_primes_below(n, list, big_number) when n >= big_number do
    IO.inspect({n, list, big_number})
    Enum.sum(list)
  end
  defp sum_of_primes_below(n, list, big_number) do
    IO.inspect({:current_number, n})
    if is_prime?(n,Enum.reverse(list)) do
      sum_of_primes_below(n+2, [n | list], big_number)
    else
      sum_of_primes_below(n+2, list, big_number)
    end
  end
  defp is_prime?(_n, []) do
    true
  end
  defp is_prime?(n, [ head | tail]) when ( head*head < n ) do
    # IO.inspect({head*head < n, n, head, tail })
    if rem(n,head) == 0 do
      false
    else
      is_prime?(n, tail)
    end
  end
  defp is_prime?(n, [ head | _tail]) do
    # IO.inspect({head*head < n, n, head, tail })
    if rem(n,head) == 0 do
      false
    else
      true
    end
  end
  
end
