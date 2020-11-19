defmodule Problem58 do
  @moduledoc """
  https://projecteuler.net/problem=58


  Spiral primes

  Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.

      37 36 35 34 33 32 31
      38 17 16 15 14 13 30
      39 18  5  4  3 12 29
      40 19  6  1  2 11 28
      41 20  7  8  9 10 27
      42 21 22 23 24 25 26
      43 44 45 46 47 48 49

  It is interesting to note that the odd squares lie along the bottom right diagonal,
  but what is more interesting is that 8 out of the 13 numbers lying along both diagonals ares
  prime; that is, a ratio of 8/13 ≈ 62%.

  If one complete new layer is wrapped around the spiral above, a square spiral with sides
  length 9 will be formed. If this process is continued, what is the side length of the
  square spiral for which the ratio of primes along both diagonals first falls below 10%?

  """

  def main() do
    time_start = Time.utc_now    # start chrono

    result = solve(99999)

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{IO.inspect result}"
    IO.puts "Execution time : #{delta_sec} s,  #{delta_msec} ms #{delta_micsec} micros"
  end #main

  def solve(n) do
    n_diags = number_spiral_diagonals(n)
    n_diags_prem = 
      n_diags 
      |> Enum.filter(&is_prime?/1)
    prime_ratio = length(n_diags_prem) / length(n_diags) * 100
    IO.inspect{n, prime_ratio}
    cond do
      prime_ratio < 10 -> n
      true -> solve(n+2)
    end

  end

  def number_spiral_diagonals(n) when rem(n,2) == 1 do
    number_spiral_diagonals(n,[1],2,1,0) 
  end

  def number_spiral_diagonals(n,[h | tail],step, count_diag, count_prime) do
    ratio = count_prime/count_diag * 100.0
    IO.inspect{step-1,ratio}
    cond do
      ratio > 9 and ratio < 10.0 -> step-1
      step+1 > n -> [ h | tail]
      true -> 
        np_primes = 
          [h + step*4, h+step*3, h+step*2, h+step]
          |> Enum.filter(&is_prime?/1)
          |> Enum.count
        number_spiral_diagonals(n, 
          [ h + step*4, h+step*3, h+step*2, h+step, h | tail ], 
          step+2, 
          count_diag+4, 
          count_prime + np_primes )
    end
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
end #module
