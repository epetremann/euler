defmodule Euler.Problem41 do
  @moduledoc """
  https://projecteuler.net/problem=41


  Pandigital prime

  We shall say that an n-digit number is pandigital if it makes use of all the digits
  1 to n exactly once.
  For example, 2143 is a 4-digit pandigital and is also prime.

  What is the largest n-digit pandigital prime that exists?

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = pandigital_prime()

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
  def pandigital_prime(n \\ 987_654_321) do
    1..n
    |> Enum.filter(&is_prime_pandigital?/1)
  end

  def is_prime_pandigital?(n) do
    is_pandigital?(n) &&
      is_prime?(n)
  end

  def is_pandigital?(n) do
    clist = Integer.to_charlist(n)
    len = length(clist)

    cond do
      len > 9 ||
        ?0 in clist ||
        clist != Enum.uniq(clist) ||
          Enum.sort(clist) != Enum.take('123456789', len) ->
        false

      true ->
        # IO.inspect({:is_pandigital, n})
        true
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
        IO.inspect({:is_prime, n})
        true

      rem(n, factor) == 0 ->
        false

      true ->
        do_is_prime?(n, factor + 2, max_factor)
    end
  end

  def power10(n) do
    cond do
      n < 10 ->
        1

      true ->
        10 * power10(div(n, 10))
    end
  end
end
