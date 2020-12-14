defmodule Euler.Problem36 do
  @moduledoc """
  https://projecteuler.net/problem=36

  Double-base palindromes

  The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.

  Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

  (Please note that the palindromic number, in either base, may not include leading zeros.)

  """

  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = double_base_palindroms(1_000_000) |> Enum.sum()

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : #{result}")
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}mec #{delta_micsec} microsec")
  end

  def double_base_palindroms(n \\ 1_000_000) do
    1..n
    |> Enum.filter(&is_palindrom?(&1, 10))
    |> Enum.filter(&is_palindrom?(&1, 2))
  end

  def is_palindrom?(n, base) when is_integer(n) do
    n |> Integer.to_string(base) |> is_palindrom?
  end

  def is_palindrom?(s) when is_bitstring(s) do
    if String.reverse(s) == s do
      true
    else
      false
    end
  end
end
