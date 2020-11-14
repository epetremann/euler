defmodule Problem37 do
  @moduledoc """
  https://projecteuler.net/problem=37

  Truncatable primes

  The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

  Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

   Note: 2, 3, 5, and 7 are not considered to be truncatable primes.

  
  """

  def main() do
    time_start = Time.utc_now    # start chrono

    result = 
      truncable_primes(1_000_000) 
      |> IO.inspect()
      |> Enum.sum

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{result}"
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}mec #{delta_micsec} microsec"
  end

  def truncable_primes(n \\ 1_000_000) do
    1..n |> Enum.filter(&is_truncable_prime?/1)
  end
  
  def is_truncable_prime?(n) do
    cond do
      n <= 10 -> false
#     n |> Integer.to_string |> String.contains?(["0", "2", "4", "5", "6", "8"]) ->
#       false
      is_prime?(n) ->
        p = power10(n) 
        is_truncable_prime_right?(div(n,10)) &&
        is_truncable_prime_left?(rem(n,p), p)
      true -> false
    end
  end
  def is_truncable_prime_right?(n) do
    cond do
      n == 0 -> true
      is_prime?(n) -> is_truncable_prime_right?(div(n,10))
      true -> false
    end
  end
  def is_truncable_prime_left?(n,p) do
    cond do
      n == 0 -> true
      p == 1 && is_prime?(n) -> true
      is_prime?(n) -> 
        p = div(p,10)
        is_truncable_prime_left?(rem(n,p), p)
      true -> false
    end
  end
  def is_prime?(n) do
    cond do
      n <= 1 -> false
      n in [2,3,5,7,11,13] -> true
      rem(n,2) == 0 -> false
      true -> 
        max_factor = n |> :math.sqrt |> ceil
        is_prime?(n, 3, max_factor)
    end
  end
  def is_prime?(n, factor, max_factor) do
    cond do
      factor > max_factor -> true
      rem(n, factor) == 0 -> false
      true -> is_prime?(n, factor+2, max_factor)
    end
  end
  def power10(n) do 
    cond do 
      n < 10 -> 1
      true -> 
        10 * power10(div(n,10))
    end
  end
end
