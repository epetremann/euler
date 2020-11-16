defmodule Problem42 do
  @moduledoc """
  https://projecteuler.net/problem=42

  Coded triangle numbers
  

  The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1);
  so the first ten triangle numbers are:

       1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

  By converting each letter in a word to a number corresponding to its alphabetical position
  and adding these values we form a word value. For example, the word value for
  SKY is 19 + 11 + 25 = 55 = t10.
  If the word value is a triangle number then we shall call the word a triangle word.

  Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing
  nearly two-thousand common English words, how many are triangle words?



  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    time_start = Time.utc_now    # start chrono

    result = coded_triangel_numbers()

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
  def coded_triangel_numbers() do
    {:ok,s} = File.read("data/p042_words.txt")
    s 
    |> String.split(~w("," "))
    |> Enum.filter(&is_triangle_word?/1)
    |> Enum.count

  end
  def word_value(s) do
    for c <- s |> String.upcase |> String.to_charlist do
      c - ?@
    end
    |> Enum.sum
  end
  def is_triangle_word?(s) do
    do_is_triangle?(word_value(s),1)
  end
  def do_is_triangle?(n,p) do
    t = div(p*(p+1),2)
    cond do
      t > n -> false
      t == n -> true
      true -> do_is_triangle?(n,p+1)
    end
  end
end
