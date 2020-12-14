defmodule Euler.Problem49 do
  @moduledoc """
  https://projecteuler.net/problem=49

  Prime permutations

  The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
  increases by 3330, is unusual in two ways: (i) each of the three terms
  are prime, and, (ii) each of the 4-digit numbers are permutations of one
  another.

  There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
  primes, exhibiting this property, but there is one other 4-digit
  increasing sequence.

  What 12-digit number do you form by concatenating the three terms in this
  sequence?
  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main(n \\ 1000) do
    # start chrono
    time_start = Time.utc_now()

    result = solve(n)

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

  def solve(n1 \\ 1001, n2 \\ 9999) do
    prime_list = n1..n2 |> Enum.filter(&is_prime?/1)

    for i <- prime_list do
      prime_list
      |> Enum.filter(&is_permutation([&1, i]))
    end
    |> Enum.uniq()
    |> Enum.filter(fn x -> Enum.count(x) >= 3 end)
    |> Enum.map(fn x -> find_arithmetic_seq(x) end)
    |> Enum.filter(fn x -> length(x) > 0 end)
    |> List.flatten()
    |> Enum.map(&concatenate/1)
  end

  def concatenate({{a, b, c}, delta}) do
    {{
       Integer.to_string(a) <>
         Integer.to_string(b) <>
         Integer.to_string(c)
     }, delta}
  end

  def find_arithmetic_seq(int_list) do
    for a <- int_list do
      for b <- int_list -- [a] do
        for c <- int_list -- [a, b] do
          if b - a == c - b and b > a do
            {{a, b, c}, b - a}
          end
        end
      end
    end
    |> List.flatten()
    |> Enum.filter(& &1)
  end

  def is_arithmetic_seq?(a, b, c) do
    b - a == c - b
  end

  def is_permutation(list) when length(list) > 1 do
    list
    |> Enum.map(&Integer.to_charlist/1)
    |> Enum.map(&Enum.sort/1)
    |> Enum.uniq()
    |> Enum.count() == 1
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
