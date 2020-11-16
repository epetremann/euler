defmodule Problem733 do
  @moduledoc """
  https://projecteuler.net/problem=733

  Ascending subsequences

  Let a(i) be the the sequence defined by a(i) = 153**i mod 10_000_019 for i >= 0
       153, (0) ,
     23409, (1) ,
   3581577, (2) ,
   7980255, (3) ,
    976697, (4) ,
   9434375, (5) ,


   Consider the subsequences consisting of 4 terms in ascending order.
   For the part of the sequence shown above, these are:
   1   153,   (1) , 23409,   (2) , 3581577, (3) , 7980255, (4) ,
   2   153,   (1) , 23409,   (2) , 3581577, (3) ,                               9434375, (6) ,
   3   153,   (1) , 23409,   (2) ,                7980255, (4) ,                9434375, (6) ,
   4   153,   (1) , 23409,   (2) ,                                976697, (5) , 9434375, (6) ,
   5   153,   (1) ,                3581577, (3) , 7980255, (4) ,                9434375, (6) ,
   6                23409,   (2) , 3581577, (3) , 7980255, (4) ,                9434375, (6) ,

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    time_start = Time.utc_now    # start chrono

    result = ascending_subsequences()

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
  def ascending_subsequences() do
    1..100 
    |> Enum.map(&a/1)
    |> Enum.sum
  end

  def a(i) do
    power(153,i) |> rem(10_000_019)
  end

  def power(_n,0), do:  1
  def power(n,p) when is_integer(p) and p > 0, do: n * power(n,p-1)


end
