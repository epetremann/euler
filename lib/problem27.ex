defmodule Euler.Problem27 do
  @moduledoc """
  https://projecteuler.net/problem=27

  Quadratic primes

  Euler discovered the remarkable quadratic formula: 
         n*n + n + 41

  It turns out that the formula will produce 40 primes for the consecutive integer values.
  However, when      n=40, 40*40+40+41 is divisible by 41, 
  and certainly when n=41, 41*41+41+41 is divisible by 41

  is clearly divisible by 41.

  The incredible formula n*n - 79*n + 1601
  was discovered, which produces 80 primes for the consecutive valuesa 0<=n<=79

  . The product of the coefficients, −79 and 1601, is −126479.

  Considering quadratics of the form: n*n + an + b, where |a|<1000 and |b|<=1000

  where |n| is the modulus/absolute value of n, e.g. |11|=11 and |-4|=4

  Find the product of the coefficients,
  and , for the quadratic expression that produces the maximum number of primes for
  consecutive values of n starting with n=0.

  """

  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = quadratic_primes()

    # stop chrono
    time_finish = Time.utc_now()

    IO.puts("Result         : #{result}")
    IO.puts("Execution time : #{Time.diff(time_finish, time_start)}s")
  end

  def quadratic_primes() do
    {product, _a, _b, _n_primes} =
      for a <- -999..999, b <- -1000..1000 do
        {a * b, a, b, number_of_consecutive_primes(a, b, 0)}
      end
      |> Enum.sort_by(fn {_, _, _, n} -> n end, :desc)
      |> hd

    product
  end

  def number_of_consecutive_primes(a, b, n) do
    candidate = abs(n * n + a * n + b)

    if is_prime?(candidate) do
      number_of_consecutive_primes(a, b, n + 1)
    else
      n
    end

    # if
  end

  # number_of_consecutive_primes

  def is_prime?(n) do
    max_factor = n |> :math.sqrt() |> ceil

    cond do
      rem(n, 2) == 0 -> false
      n in [1, 2, 3, 5] -> true
      true -> is_prime?(n, 3, max_factor)
    end
  end

  def is_prime?(n, factor, max_factor) do
    cond do
      factor > max_factor -> true
      rem(n, factor) == 0 -> false
      true -> is_prime?(n, factor + 2, max_factor)
    end
  end
end
