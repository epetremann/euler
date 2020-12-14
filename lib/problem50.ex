defmodule Euler.Problem50 do
  @moduledoc """
  https://projecteuler.net/problem=50

  Consecutive prime sum

  The prime 41, can be written as the sum of six consecutive primes:
  41 = 2 + 3 + 5 + 7 + 11 + 13

  This is the longest sum of consecutive primes that adds to a prime below one-hundred.

  The longest sum of consecutive primes below one-thousand that adds to a prime,
  contains 21 terms, and is equal to 953.

  Which prime, below one-million, can be written as the sum of the most consecutive primes?


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve(1_000_000)

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
  def solve(n_max \\ 1_000_000) do
    prime_list_sum = sum_prime(n_max)
    imax = (prime_list_sum |> Enum.count()) - 1

    [{_, result, _}] =
      for i <- 0..(imax - 1) do
        {p1, acc1} = prime_list_sum |> Enum.at(i)

        for j <- (i + 1)..imax do
          {p2, acc2} = prime_list_sum |> Enum.at(j)
          sum_floating = p1 + acc2 - acc1

          if is_prime?(sum_floating) do
            {{p1, p2}, sum_floating, j - i + 1}
          end
        end
        |> Enum.filter(& &1)
      end
      |> List.flatten()
      |> Enum.sort_by(fn {_, _, delta} -> delta end)
      |> Enum.filter(fn {_, acc, _} -> acc < n_max end)
      |> Enum.take(-1)

    result
  end

  def sum_prime(nmax) do
    do_sum_prime(3, 2, [{2, 2}], nmax)
  end

  def do_sum_prime(n, acc, list, nmax) do
    cond do
      acc > nmax -> list |> Enum.reverse()
      is_prime?(n) -> do_sum_prime(n + 2, acc + n, [{n, acc + n} | list], nmax)
      true -> do_sum_prime(n + 2, acc, list, nmax)
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
