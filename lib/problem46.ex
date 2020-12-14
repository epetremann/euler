defmodule Euler.Problem46 do
  @moduledoc """
  https://projecteuler.net/problem=46

  Goldbach's other conjecture


  It was proposed by Christian Goldbach that every odd composite number can be written as the
  sum of a prime and twice a square.

      9 = 7 + 2×12
      15 = 7 + 2×22
      21 = 3 + 2×32
      25 = 7 + 2×32
      27 = 19 + 2×22
      33 = 31 + 2×12

  It turns out that the conjecture was false.

  What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve(5)

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

  def solve(x \\ 5) do
    if not is_prime?(x) and not is_goldbachs?(x) do
      x
    else
      solve(x + 2)
    end
  end

  def is_goldbachs?(x) do
    do_is_goldbachs?(x, x - 2)
  end

  def do_is_goldbachs?(x, p) do
    # There exist a q such as 2*q*q = x-p 
    if p == 1 do
      false
    else
      if is_prime?(p) do
        q = ceil(:math.sqrt(div(x - p, 2)))

        if 2 * q * q == x - p do
          true
        else
          do_is_goldbachs?(x, p - 2)
        end
      else
        do_is_goldbachs?(x, p - 2)
      end
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
