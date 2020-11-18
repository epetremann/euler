defmodule Problem55 do
  @moduledoc """
  https://projecteuler.net/problem=55

  Lychrel numbers

  If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.

  Not all numbers produce palindromes so quickly. For example,

      349 + 943 = 1292,
      1292 + 2921 = 4213
      4213 + 3124 = 7337

  That is, 349 took three iterations to arrive at a palindrome.

  Although no one has proved it yet, it is thought that some numbers, like 196, never
  produce a palindrome. A number that never forms a palindrome through the reverse and
  add process is called a Lychrel number. Due to the theoretical nature of these numbers,
  and for the purpose of this problem, we shall assume that a number is Lychrel until
  proven otherwise. In addition you are given that for every number below ten-thousand,
  it will either (i) become a palindrome in less than fifty iterations, or, (ii) no one,
  with all the computing power that exists, has managed so far to map it to a palindrome.
  In fact, 10677 is the first number to be shown to require over fifty iterations before
  producing a palindrome: 4668731596684224866951378664 (53 iterations, 28-digits).

  Surprisingly, there are palindromic numbers that are themselves Lychrel numbers;
  the first example is 4994.

  How many Lychrel numbers are there below ten-thousand?

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main(n \\ 1000) do
    time_start = Time.utc_now    # start chrono

    result = solve(n)

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : "
    IO.inspect result
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec"
  end

  def solve(n\\ 9_999) do
    for i <- 10..n do
      if not is_palindrom_gen?(i, 50) do
        i
      end
    end
    |> Enum.filter(&(&1))
    |> Enum.count
  end

  def is_palindrom_gen?(_n,0), do: false
  def is_palindrom_gen?(n,p) do
    new_n = n+reverse(n)
    if is_palindrom?(new_n) do
      true
    else
      is_palindrom_gen?(new_n, p-1)
    end
  end

  def reverse(x) when is_integer(x) do
    x 
    |> Integer.to_string
    |> String.reverse
    |> String.to_integer
  end
  def is_palindrom?(n) do
    n_string = Integer.to_string(n)
    n_string == String.reverse(n_string)
  end
end
