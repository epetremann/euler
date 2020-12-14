defmodule Euler3 do
  @moduledoc """
  https://projecteuler.net/problem=3

  Problem 3:


  The prime factors of 13195 are 5, 7, 13 and 29.

  What is the largest prime factor of the number 600851475143 ?

  """

  @doc """
  Multiples of 3 and 5 smaller than n
  simple method not optimised


  """

  # if number is pair and bigger than 2, divide it by 2
  def biggest_prime_factor(n) when n > 2 and rem(n, 2) == 0 do
    biggest_prime_factor(div(n, 2))
  end

  # try with all odd numbers from 3 to sqrt(n)
  def biggest_prime_factor(n) do
    biggest_prime_factor(n, 3, floor(:math.sqrt(n)) + 1)
  end

  def biggest_prime_factor(n, f, fmax) when n <= f or fmax <= f do
    IO.puts("n=#{n},f=#{f}, fmax=#{fmax}")
    n
  end

  def biggest_prime_factor(n, f, fmax) do
    # IO.puts "n=#{n},f=#{f}, fmax=#{fmax}"
    {n, f} =
      if rem(n, f) == 0 do
        {div(n, f), f}
      else
        {n, f + 2}
      end

    biggest_prime_factor(n, f, fmax)
  end
end
