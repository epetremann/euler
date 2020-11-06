defmodule Problem21 do
  @moduledoc """
  https://projecteuler.net/problem=21

  Amicable numbers

  

  Let d(n) be defined as the sum of proper divisors of n 
  (numbers less than n which divide evenly into n).
  If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair
  and each of a and b are called amicable numbers.

  For example, the proper divisors of 220 are:
    1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110;s
  therefore d(220) = 284. 
  The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

  Evaluate the sum of all the amicable numbers under 10000.

  """

  @doc """


  """

  def amicable_numbers(n \\ 10_000) do
    for i <- 1..n do
      x = d(i)
      if x != i and d(x) == i do
        i
      else
        0
      end
    end |> Enum.sum
  end
  
  def d(n) do
    find_proper_divisors(n) |> Enum.sum
  end
  def find_proper_divisors(n) do
    find_proper_divisors(n, 2, [1])
  end
  def find_proper_divisors(n,f, divisors) do 
    cond do
      f >= ceil(:math.sqrt(n)) -> divisors |> Enum.sort
      rem(n,f) == 0 -> 
        find_proper_divisors(n,f+1, [f, div(n,f) | divisors])
      true -> 
        find_proper_divisors(n, f+1, divisors)
    end
  end

end
