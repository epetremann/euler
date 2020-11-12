defmodule Problem63 do
  @moduledoc """
  https://projecteuler.net/problem=63

  Powerful digit counts


  The 5-digit number, 16807=7^^5, is also a fifth power. 
  Similarly, the 9-digit number, 134217728=8^^9, is a ninth power.

  How many n-digit positive integers exist which are also an nth power?


  """

  def main() do
    time_start = Time.utc_now    # start chrono

    result = powerful_digit_counts(100)

    time_finish = Time.utc_now   # stop chrono

    IO.puts "Result         : #{result}"
    IO.puts "Execution time : #{Time.diff(time_finish,time_start)}s"
  end #main

  def powerful_digit_counts(n) do
    powerful_digit_counts(n,1,1,[])
  end
  def powerful_digit_counts(n,p,i,list) do
      cond do
        p > n -> list
        i > 9 -> powerful_digit_counts(n,p+1,1,list)
        power_dig_count(i,p) == p -> powerful_digit_counts(n,p,i+1,[{i,p} | list])
        true -> powerful_digit_counts(n,p,i+1, list)
    end
  end

  def power_dig_count(n,p) do
    power(n,p) |> to_charlist |> length
  end
  def power(n,p) do
    case p do
      0 -> 1
      _ -> n*power(n,p-1)
    end
  end
  
end #module
