defmodule Problem52 do
  @moduledoc """
  https://projecteuler.net/problem=52

  Permuted multiples

  

  It can be seen that the number, 125874, and its double, 251748, contain
  exactly the same digits, but in a different order.

  Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main() do
    time_start = Time.utc_now    # start chrono

    result = solve()

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{IO.inspect result}"
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec"
  end
  def solve(n \\ 2) do
    int_list = [n, 2*n, 3*n, 4*n, 5*n, 6*n ]
    cond do
      is_same_digits?(int_list) -> int_list
      true -> solve(n+1)
    end
  end


  def is_same_digits?(int_list) do
    int_list 
    |> Enum.map(&Integer.to_charlist/1)
    |> Enum.map(&Enum.sort/1)
    |> Enum.uniq
    |> Enum.count == 1

  end


end
