defmodule Euler.Problem1 do
  @moduledoc """
  https://projecteuler.net/problem=1

  Multiples of 3 and 5

  Problem 1

  If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
  The sum of these multiples is 23.

  Find the sum of all the multiples of 3 or 5 below 1000.
  """

  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = sum_of_mult_of_3_5(1_000)

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : #{result}")
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}mec #{delta_micsec} microsec")
  end

  # main

  @doc """
  The sum of integers 1 to n1 is given by the formula n*(n-1)/2
  """

  def sum_of_mult(n, p) do
    n1 = div(n - 1, p)
    div(n1 * (n1 + 1), 2) * p
  end

  def sum_of_mult_of_3_5(n) do
    sum_of_mult(n, 3) +
      sum_of_mult(n, 5) -
      sum_of_mult(n, 15)
  end
end
