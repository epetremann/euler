defmodule Euler.Problem57 do
  @moduledoc """
  https://projecteuler.net/problem=57

  Square root convergents
  It is possible to show that the square root of two can be expressed as an infinites
  continued fraction.

  By expanding:

  1 + 1/2 = 3/2
  1 + 1/(2+1/2) = 7/5
  1 + 1/(2+1/(2+1/2)) = 17/12
  1 + 1/(2+1/(2+1/(2+1/2))) = 41/29

  next expansions are : 99/70, 239/169 and 577/408.
  The eighth expansion 1393/985 is the first example where the number of digits ins
  the numerator exceeds the number of digits in the denominator.

  In the first one-thousand expansions, how many fractions contain a numerator with
  more digits than the denominator?

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main(n \\ 1000) do
    # start chrono
    time_start = Time.utc_now()

    result = solve(n)

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : #{IO.inspect(result)}")
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec")
  end

  def solve(n \\ 1000) do
    do_solve(n, {1, 2}, 0)
  end

  def do_solve(0, {_t, _b}, count), do: count

  def do_solve(n, {t, b}, count) do
    {new_t, new_b} = {b, 2 * b + t}
    {numerator, denominator} = {3 * b + t, 2 * b + t}

    count =
      if count_digits(numerator) > count_digits(denominator) do
        count + 1
      else
        count
      end

    # IO.inspect {n-1, {new_t, new_b}, count}

    do_solve(n - 1, {new_t, new_b}, count)
  end

  def count_digits(n) when n < 10, do: 1
  def count_digits(n), do: 1 + count_digits(div(n, 10))
end
