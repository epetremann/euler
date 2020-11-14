defmodule Problem35 do
  @moduledoc """
  https://projecteuler.net/problem=35

  Circular primes

  The number, 197, is called a circular prime because all rotations of the digits:
  197, 971, and 719, are themselves prime.

  There are thirteen such primes below 100:
  2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

  How many circular primes are there below one million?

  
  """

  def main() do
    time_start = Time.utc_now    # start chrono

    result = circular_primes(1_000_000) |> length

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{result}"
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}mec #{delta_micsec} microsec"
  end

  def circular_primes(n \\ 1_000_000) do
    1..n 
    |> Enum.filter(&is_prime?/1)
    |> Enum.filter(&is_circular_prime?/1)

  end


  def is_circular_prime?(n) do
    rotations(n)
    |> Enum.all?(&is_prime?/1)
  end


  def rotations(n) do
    p10 = power10(n)
    index = ceil(:math.log10(p10))
    rotations(n, p10, index, [n])
  end
  def rotations(n, p10, index, list) do
    cond do
      index == 0 -> list
      true -> 
        n2 = rem(n,p10)*10 + div(n,p10)
        rotations(n2, p10, index-1, [n2 | list])
    end
  end

  def power10(n) do 
    cond do 
      n < 10 -> 1
      true -> 
        10 * power10(div(n,10))
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
  
end
