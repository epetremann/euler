defmodule Problem51 do
  @moduledoc """
  https://projecteuler.net/problem=51


  Prime digit replacements

  By replacing the 1st digit of the 2-digit number *3, it turns out that six of the
  nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

  By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number
  is the first example having seven primes among the ten generated numbers, yielding the family:
  56003, 56113, 56333, 56443, 56663, 56773, and 56993.
  Consequently 56003, being the first member of this family, is the smallest prime with this
  property.

  Find the smallest prime which, by replacing part of the number (not necessarily adjacent
  digits) with the same digit, is part of an eight prime value family.

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve(1001,7)

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : #{IO.inspect(result)}")
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec")
  end

  @doc """
  """
  def solve(n \\ 1001, digits \\ 8) do
    if is_prime?(n) and check_repl?(n, digits) do
      n
    else
      solve(n + 1, digits)
    end
  end

  def check_repl?(n, digits) do
    IO.inspect(n)
    l_n = Integer.digits(n)
    len = length(l_n)

    for i <- 0..(len - 3), j <- (i + 1)..(len - 2), k <- (j + 1)..(len - 1) do
      x_i = Enum.at(l_n, i)
      x_j = Enum.at(l_n, j)
      x_k = Enum.at(l_n, k)

      if x_i == x_j and x_i == x_k and 9 - x_i >= digits - 1 do
        for y <- (x_i + 1)..9 do
          temp_n =
            l_n
            |> List.replace_at(i, y)
            |> List.replace_at(j, y)
            |> List.replace_at(k, y)
            |> Integer.undigits()

          if is_prime?(temp_n) do
            1
          else
            0
          end
        end
        |> Enum.sum()
      else
        0
      end
    end
    |> List.flatten()
    |> Enum.max() >= digits - 1
  end

  # check_repl?

  def is_prime?(n) do
    cond do
      n <= 1 ->
        false

      n in [2, 3, 5, 7, 11, 13] ->
        true

      rem(n, 2) == 0 ->
        false

      true ->
        max_factor = n |> :math.sqrt() |> ceil
        do_is_prime?(n, 3, max_factor)
    end
  end

  def do_is_prime?(n, factor, max_factor) do
    cond do
      factor > max_factor ->
        true

      rem(n, factor) == 0 ->
        false

      true ->
        do_is_prime?(n, factor + 2, max_factor)
    end
  end
end
