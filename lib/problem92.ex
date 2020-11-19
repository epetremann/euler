defmodule Problem92 do
  @moduledoc """
  https://projecteuler.net/problem=92

  Square digit chains

  A number chain is created by continuously adding the square of the digits in a number to
  form a new number until it has been seen before.

  For example,

      44 → 32 → 13 → 10 → 1 → 1
      85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

  Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop.
  What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.

  How many starting numbers below ten million will arrive at 89?


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main(n \\ 9_999_999) do
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

  @doc """
  """
  def solve(n \\ 9_999_999) do
    do_solve(n, 0)
  end
  def do_solve(1,counter), do: counter
  def do_solve(n,counter) do
    if number_chain(n) == 89 do
      do_solve(n-1, counter+1)
    else
      do_solve(n-1, counter)
    end
  end

  def number_chain(n) do
    case square_dig = square_digits(n) do
      89 ->  89
      1 -> 1
      _ -> number_chain(square_dig)
    end
  end
  def square_digits(0), do: 0
  def square_digits(n) do
    digit = rem(n,10) 
    digit * digit + square_digits(div(n,10))
  end
end
