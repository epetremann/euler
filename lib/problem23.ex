defmodule Euler.Problem23 do
  @moduledoc """
  https://projecteuler.net/problem=23

  Non-abundant sums

  Problem 23

  A perfect number is a number for which the sum of its proper divisors
  is exactly equal to the number.s
  For example, the sum of the proper divisors of 28 would be
  1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

  A number n is called deficient if the sum of its proper divisors is less than n
  and it is called abundant if this sum exceeds n.

  As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16,
  the smallest number that can be written as the sum of two abundant numbers is 24.

  By mathematical analysis, it can be shown that all integers greater than 28123
  can be written as the sum of two abundant numbers.

  However, this upper limit cannot be reduced any further by analysis even though
  it is known that the greatest number that cannot be expressed as the sum of two
  abundant numbers is less than this limit.

  Find the sum of all the positive integers which cannot be written as the sum of
  two abundant numbers.


  """

  @doc """
  main function of current module

  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = non_abundant_sum()

    # stop chrono
    time_finish = Time.utc_now()

    IO.puts("Result         : #{result}")
    IO.puts("Execution time : #{Time.diff(time_finish, time_start)}s")
  end

  def non_abundant_sum() do
    list_abundants = get_list_abundants()

    sum =
      2..28123
      |> Enum.filter(fn x -> not is_sum_of_two_abundant?(x, list_abundants) end)
      |> Enum.sum()

    sum + 1
  end

  # non_abundant_sum

  def find_divisors(n) do
    d = floor(:math.sqrt(n))

    if d * d == n do
      find_divisors(d - 1, n, [d])
    else
      find_divisors(d, n, [])
    end
  end

  # find_divisors

  def find_divisors(1, _n, list) do
    [1 | list] |> Enum.sort()
  end

  def find_divisors(d, n, list) do
    if rem(n, d) == 0 do
      find_divisors(d - 1, n, [d, div(n, d) | list])
    else
      find_divisors(d - 1, n, list)
    end
  end

  # find_divisors

  def is_abundant?(n) do
    n |> find_divisors |> Enum.sum() > n
  end

  def get_list_abundants(n \\ 28123) do
    2..n |> Enum.filter(fn x -> is_abundant?(x) end)
  end

  def is_sum_of_two_abundant?(_n, []) do
    false
  end

  def is_sum_of_two_abundant?(n, [h | tail]) do
    cond do
      2 * h > n -> false
      2 * h == n or (n - h) in tail -> true
      true -> is_sum_of_two_abundant?(n, tail)
    end
  end

  # is_sum_of_two_abundant?
end

# module
