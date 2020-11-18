defmodule Problem97 do
  @moduledoc """
  https://projecteuler.net/problem=97

  Large non-Mersenne prime


  The first known prime found to exceed one million digits was discovered in 1999, and is a Mersenne prime of the form 26972593−1; it contains exactly 2,098,960 digits. Subsequently other Mersenne primes, of the form 2p−1, have been found which contain more digits.

  However, in 2004 there was found a massive non-Mersenne prime which contains 2,357,207 digits: 
       28433*(2**7830457)+1.

  Find the last ten digits of this prime number.


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    time_start = Time.utc_now    # start chrono

    result = solve()

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
  def pow(_n,0), do: 1
  def pow(n,p) when is_integer(p) and p > 0, do: n*pow(n,p-1)
  def powmod(_n,_m,0), do: 1
  def powmod(n,m, p) when is_integer(p) and p > 0, do: n*powmod(n,m, p-1) |> rem(m)
  def solve() do
    nil
  end
end
