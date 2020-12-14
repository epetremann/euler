defmodule Euler.Problem47 do
  @moduledoc """
  https://projecteuler.net/problem=47

  Distinct primes factors

  The first two consecutive numbers to have two distinct prime factors are:

      14 = 2 × 7
      15 = 3 × 5

  The first three consecutive numbers to have three distinct prime factors are:

      644 = 2² × 7 × 23
      645 = 3 × 5 × 43
      646 = 2 × 17 × 19.

  Find the first four consecutive integers to have four distinct prime factors each.
  What is the first of these numbers?

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve(1, 4)

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : ")
    IO.inspect(result)
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec")
  end

  def solve(n, p) do
    if n..(n + p - 1) |> Enum.all?(&(primitive_fact_count(&1) == p)) do
      IO.inspect({:"n   ", n, :factors, decompose(n)})
      IO.inspect({:"n+1 ", n + 1, :factors, decompose(n + 1)})
      IO.inspect({:"n+2 ", n + 2, :factors, decompose(n + 2)})
      IO.inspect({:"n+3 ", n + 3, :factors, decompose(n + 3)})
      n
    else
      solve(n + 1, p)
    end
  end

  def primitive_fact_count(n) do
    length(decompose(n))
  end

  def decompose(n) do
    do_decompose(n, 2, [])
  end

  def do_decompose(n, p, list) when p > n do
    list
  end

  def do_decompose(n, 2, list) do
    cond do
      rem(n, 2) == 0 ->
        # add the element to list if not already included
        do_decompose(div(n, 2), 2, Enum.uniq([2 | list]))

      true ->
        do_decompose(n, 3, list)
    end
  end

  def do_decompose(n, p, list) do
    cond do
      is_prime?(n) ->
        Enum.uniq([n | list])

      is_prime?(p) and rem(n, p) == 0 ->
        # add the element to list if not already included
        do_decompose(div(n, p), p, Enum.uniq([p | list]))

      true ->
        do_decompose(n, p + 2, list)
    end
  end

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
