defmodule Euler.Problem34 do
  @moduledoc """
  https://projecteuler.net/problem=34


  Digit factorials

  145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

  Find the sum of all numbers which are equal to the sum of the factorial
  of their digits.

  Note: As 1! = 1 and 2! = 2 are not sums they are not included.


  """

  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = digit_factorials()

    # stop chrono
    time_finish = Time.utc_now()
    time_sec = Time.diff(time_finish, time_start)

    time_msec =
      Time.diff(time_finish, time_start, :microsecond)
      |> rem(1_000_000)
      |> div(1000)

    IO.puts("Result         : #{result}")
    IO.puts("Execution time : #{time_sec}sec,  #{time_msec} msec")
  end

  # main

  def digit_factorials() do
    for i <- 3..1000_000_000 do
      if is_sum_of_dig_fact_equal?(i) do
        IO.inspect(i)
        i
      else
        0
      end
    end
    |> Enum.filter(fn x -> x > 0 end)
    |> Enum.sum()
  end

  def is_sum_of_dig_fact_equal?(n) do
    sum_of_dig_fact(n) == n
  end

  def sum_of_dig_fact(n) do
    case n do
      0 -> 0
      _ -> fact(rem(n, 10)) + sum_of_dig_fact(div(n, 10))
    end
  end

  def fact(n) do
    case n do
      0 -> 1
      _ -> n * fact(n - 1)
    end
  end
end

# module
