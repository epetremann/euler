defmodule Problem50 do
  @moduledoc """
  https://projecteuler.net/problem=50

  Consecutive prime sum

  The prime 41, can be written as the sum of six consecutive primes:
  41 = 2 + 3 + 5 + 7 + 11 + 13

  This is the longest sum of consecutive primes that adds to a prime below one-hundred.

  The longest sum of consecutive primes below one-thousand that adds to a prime,
  contains 21 terms, and is equal to 953.

  Which prime, below one-million, can be written as the sum of the most consecutive primes?


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    time_start = Time.utc_now    # start chrono

    result = consecuteive_prime_sum(1_000_000)

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
  def consecuteive_prime_sum(n \\ 100_000, smax \\ 1_000_000) do
    prime_list = 1..n-1 |> Enum.filter(&is_prime?/1)
    prime_count = Enum.count(prime_list)
    for a <- 0..prime_count-1 do
      for b <- a+1..prime_count do
        prime_seq = prime_list |> Enum.slice(a,b)
        prime_seq_sum = prime_seq |> Enum.sum
        if is_prime?(prime_seq_sum) do
          {prime_seq_sum, b }
        end
      end
    end 
    |> List.flatten
    |> Stream.filter(fn x -> x != nil end)
    |> Enum.sort_by(fn {_x,y} -> y end)
    |> Stream.filter(fn {x,_y,} ->  x < smax end)
    |> Enum.take(-6)
  end

  def is_prime?(n) do
    cond do
      n <= 1 -> false
      n in [2,3,5,7,11,13] -> true
      rem(n,2) == 0 -> false
      true -> 
        max_factor = n |> :math.sqrt |> ceil
        do_is_prime?(n, 3, max_factor)
    end
  end
  def do_is_prime?(n, factor, max_factor) do
    cond do
      factor > max_factor -> 
        true
      rem(n, factor) == 0 -> false
      true -> do_is_prime?(n, factor+2, max_factor)
    end
  end
end
