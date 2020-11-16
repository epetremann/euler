defmodule Problem33 do
  @moduledoc """
  https://projecteuler.net/problem=33

  Digit cancelling fractions

  The fraction 49/98 is a curious fraction, as an inexperienced mathematician in
  attempting to simplify it may incorrectly believe that 49/98 = 4/8,
  which is correct, is obtained by cancelling the 9s.

  We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

  There are exactly four non-trivial examples of this type of fraction,s
  less than one in value, and containing two digits in the numerator and denominator.

  If the product of these four fractions is given in its lowest common terms,
  find the value of the denominator.

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    time_start = Time.utc_now    # start chrono

    result = digit_cancel_fract()

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : "
    IO.inspect result
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec"
  end

  @doc """
  """
  def digit_cancel_fract() do
    for top <- 10..99 do
      for bottom <- top+1..99 do 
        {t1,t2} = {rem(top,10),div(top,10)}
        {b1,b2} = {rem(bottom,10),div(bottom,10)}
        cond do
          top/bottom < 1 and t1 == b2  and b1 != 0 and t2/b1 == top/bottom -> {top,bottom}
          top/bottom < 1 and t2 == b1  and b2 != 0 and t1/b2 == top/bottom -> {top,bottom}
          true -> nil
        end
      end
    end
    |> List.flatten
    |> Enum.filter(fn x -> x != nil end)
    |> IO.inspect
    |> Enum.map(fn {a,b} -> {div(a,10), rem(b,10)} end)
    |> Enum.reduce({1,1}, fn {a,b},{aca,acb} -> {a*aca, b*acb} end)
  end
end
