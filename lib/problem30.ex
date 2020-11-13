defmodule Problem30 do
  @moduledoc """
  https://projecteuler.net/problem=30

  Digit fifth powers

  Surprisingly there are only three numbers that can be written as the sum
  of fourth powers of their digits:

    1634 = 1**4 + 6**4 + 3**4 + 4**4
    8208 = 8**4 + 2**4 + 0**4 + 8**4
    9474 = 9**4 + 4**4 + 7**4 + 4**4

  As 1 = 14 is not a sum it is not included.

  The sum of these numbers is 1634 + 8208 + 9474 = 19316.

  Find the sum of all the numbers that can be written as the sum of fifth
  powers of their digits.

  """

  def main() do
    time_start = Time.utc_now    # start chrono

    result = digit_fifth_powers()

    time_finish = Time.utc_now   # stop chrono
    time_sec = Time.diff(time_finish, time_start)
    time_msec =
      Time.diff(time_finish, time_start, :microsecond)
      |> rem(1_000_000)
      |> div(1000)

    IO.puts "Result         : #{result}"
    IO.puts "Execution time : #{time_sec}sec,  #{time_msec} msec"
  end #main

  def digit_fifth_powers(p \\ 5, nmax \\ 1_000_000) do
    2..nmax 
    |> Enum.filter(fn x -> digits_power_sum(x, p, 0) == x end)
    |> Enum.sum
  end

  def digits_power_sum(n, p, acc) do
    case n do
      0 -> acc
      _ -> digits_power_sum(div(n,10), p, acc + power(rem(n,10),p))
    end
  end
  def digits(n,list) do
    case n do
      0 -> list
      _ -> digits(div(n,10), [rem(n,10) | list])
    end
  end

  def power(a,b) do
    cond do
      b <= 0 -> 1
      true -> a*power(a,b-1)
    end
  end
  
end #module
