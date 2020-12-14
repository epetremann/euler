defmodule Euler.Problem74 do
  @moduledoc """
  https://projecteuler.net/problem=74

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve()

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : #{IO.inspect(result)}")
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec")
  end

  def solve(n \\ 999_999) do
    do_solve(n, 0)
  end

  def do_solve(0, count), do: count

  def do_solve(n, count) do
    chain_length = chain_digit_facts(n)

    if chain_length == 60 do
      IO.inspect({n, count, digit_fact(n)})
      do_solve(n - 1, count + 1)
    else
      do_solve(n - 1, count)
    end
  end

  def chain_digit_facts(n) do
    do_chain_digit_facts(n, [])
  end

  def do_chain_digit_facts(n, n_list) do
    if n in n_list do
      n_list |> Enum.count()
    else
      do_chain_digit_facts(digit_fact(n), [n | n_list])
    end
  end

  def digit_fact(n) do
    cond do
      n < 10 -> fact(n)
      true -> fact(rem(n, 10)) + digit_fact(div(n, 10))
    end
  end

  def fact(0), do: 1
  def fact(1), do: 1
  def fact(2), do: 2
  def fact(3), do: 6
  def fact(4), do: 24
  def fact(5), do: 120
  def fact(6), do: 720
  def fact(7), do: 5040
  def fact(8), do: 40320
  def fact(9), do: 362_880
  def fact(n), do: n * fact(n - 1)
end
