defmodule Problem56 do
  @moduledoc """
  https://projecteuler.net/problem=56


  Powerful digit sum

  A googol (10**100) is a massive number: one followed by one-hundred zeros;
  100**100 is almost unimaginably large: one followed by two-hundred zeros. 
  Despite their size, the sum of the digits in each number is only 1.

  Considering natural numbers of the form, ab, where a, b < 100, what is the maximum digital sum?

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main(n \\ 99) do
    time_start = Time.utc_now    # start chrono

    result = solve(n)

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{IO.inspect result}"
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec"
  end

  def solve(start \\ 99) do
    do_solve(start, start, start, 0)
  end

  def do_solve(0, 0, _start, acc) do
    acc
  end
  def do_solve(a, 0, start, acc) do
      do_solve(a-1, start, start, acc)
  end
  def do_solve(a, b, start, acc) do
      do_solve(a, b-1, start, max(acc, dig_sum(pow(a,b))))
  end

  def dig_sum(0), do: 0
  def dig_sum(n), do: rem(n,10)+dig_sum(div(n,10))
  def pow(_n,0), do: 1
  def pow(n,p), do: n*pow(n,p-1)
end
