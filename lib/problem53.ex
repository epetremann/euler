defmodule Problem53 do
  @moduledoc """
  https://projecteuler.net/problem=53

  Combinatronic selections.

  There are exactly ten ways of selecting three from five, 12345:

        123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

  In combinatorics, we use the notation:
      C(n,r) = n!/(r!(n-r)!)

  It is not until n=23, that a value exceeds one-million:
  C(23,10) = 1144066

  How many, not necessarily distinct, values of C(n,r) for 1 <= n <= 100
  for , are greater than one-million?

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main(n \\ 100) do
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
  def solve(n \\ 100) do
    for n <- 23..n do
      for r <- 2..n-1 do
        c = comb(n,r)
        if c > 1_000_000 do
          {{n,r}, c}
        else
          nil
        end
      end
      |> Enum.filter(&(&1))
    end
    |> List.flatten
    |> Enum.count
  end

  def comb(n,r) do
    div(fact(n),fact(r)*fact(n-r))
  end
  def comb2(n,r) do
    if r >= n-r do
      (r+1)..n 
      |> Enum.reduce(1, &(&1*&2))
      |> div(fact(n-r))
    else
      (n-r)..n
      |> Enum.reduce(1, &(&1*&2))
      |> div(fact(r))
    end
  end
  def fact(0), do: 1
  def fact(n), do: n*fact(n-1)
  def fact2(n) do 
    1..n 
    |> Enum.reduce(1, &(&1*&2)) 
  end
end
