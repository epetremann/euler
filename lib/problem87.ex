defmodule Euler.Problem87 do
  @moduledoc """
  https://projecteuler.net/problem=87

  Prime power triples

  The smallest number expressible as the sum of a prime square, prime cube, and prime fourth power is 28.
  In fact, there are exactly four numbers below fifty that can be expressed in such a way:

    28 = 22 + 23 + 24
    33 = 32 + 23 + 24
    49 = 52 + 23 + 24
    47 = 22 + 33 + 24

  How many numbers below fifty million can be expressed as the sum of a prime square, prime cube, and prime fourth power?
  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main(nmax \\ 50_000_000) do
    # start chrono
    time_start = Time.utc_now()

    result = solve(nmax)

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
  def solve(nmax \\ 50_000_000) do
    {prime_squares, prime_cubes, prime_fourths} = prime_powers(nmax)

    for i <- prime_fourths do
      for j <- prime_cubes, i + j < nmax do
        for k <- prime_squares, i + j + k < nmax do
          i + j + k
        end
        |> Enum.filter(& &1)
      end
    end
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  @doc """
  The function primes_power generates three lists { prime_squares, prime_cubes , primes_fourths}
  """
  def prime_powers(nmax) do
    do_prime_powers(nmax, 3, [pow(2, 2)], [pow(2, 3)], [pow(2, 4)])
  end

  def do_prime_powers(nmax, i, prime_squares, prime_cubes, prime_fourths) do
    square = i * i
    cube = square * i
    fourth = cube * i

    cond do
      not is_prime?(i) ->
        do_prime_powers(nmax, i + 2, prime_squares, prime_cubes, prime_fourths)

      fourth < nmax ->
        do_prime_powers(nmax, i + 2, [square | prime_squares], [cube | prime_cubes], [
          fourth | prime_fourths
        ])

      cube < nmax ->
        do_prime_powers(
          nmax,
          i + 2,
          [square | prime_squares],
          [cube | prime_cubes],
          prime_fourths
        )

      square < nmax ->
        do_prime_powers(nmax, i + 2, [square | prime_squares], prime_cubes, prime_fourths)

      true ->
        {prime_squares, prime_cubes, prime_fourths}
    end
  end

  def pow(n, p) do
    case p do
      0 -> 1
      _ -> n * pow(n, p - 1)
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
