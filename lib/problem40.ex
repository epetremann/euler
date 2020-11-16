defmodule Problem40 do
  @moduledoc """
  https://projecteuler.net/problem=40

  Champernowne's constant

  An irrational decimal fraction is created by concatenating the positive integers:

    0.123456789101112131415161718192021...

  It can be seen that the 12th digit of the fractional part is 1.

  If dn represents the nth digit of the fractional part, find the value of the following expression.

  d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
# def main(fun_test \\ &pandigital_multiples/1 , 
#          param \\ 1_000_000) do
  def main() do
    time_start = Time.utc_now    # start chrono

    result = champernowne()

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
  def champernowne() do
    long_string = cumulate_s_positive(6)
    for x <- [1,10,100,1_000,10_000,100_000,1_000_000] do
      String.at(long_string,x-1) 
    end 
    |> Enum.map(fn(x)->String.to_integer(x) end)
    |> Enum.reduce(1, fn(x,acc)->acc*x end)
  end
  def s_positive(n) do
    start = power(10,n-1)
    finish = power(10,n)-1
    start..finish |> Stream.map(fn x -> Integer.to_string(x) end) |> Enum.join("")
  end
  def cumulate_s_positive(n) do
    for i <- 1..n do
      s_positive(i)
    end |> Enum.join("")
  end
  def power(_,0), do: 1
  def power(n,p), do: n * power(n,p-1)
end
