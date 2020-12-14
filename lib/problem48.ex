defmodule Euler.Problem48 do
  @moduledoc """
  https://projecteuler.net/problem=48

  Self powers


   The series, 1**1 + 2**2 + 3**3 + ... + 10**10 = 10405071317.

   Find the last ten digits of the series, 1**1 + 2**2 + 3**3 + ... + 1000**1000.

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = self_powers(1_000)

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : #{IO.inspect(result)}")
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec")
  end

  @doc """
  """
  def self_powers(nmax) do
    1..nmax
    |> Stream.map(fn x -> power(x, x) end)
    |> Enum.sum()
    |> Integer.to_charlist()
    |> Enum.take(-10)
  end

  def power(_n, 0), do: 1
  def power(n, p) when is_integer(p) and p > 0, do: n * power(n, p - 1)
end
