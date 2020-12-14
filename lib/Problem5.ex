defmodule Euler5 do
  @moduledoc """
  https://projecteuler.net/problem=5

  Smallest multiple

  2520 is the smallest number that can be divided by each of the numbers from 1 to 10 
  without any remainder.

  What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
  """

  @doc """

  """

  def pgcd(a, b) when b > a do
    pgcd(b, a)
  end

  def pgcd(a, b) do
    r = rem(a, b)

    if r == 0 do
      b
    else
      pgcd(b, r)
    end
  end

  def reduce([], n), do: n
  def reduce([h | tail], n), do: reduce(tail, div(n, pgcd(n, h)))

  def add_element(x, list) do
    [reduce(list, x) | list]
  end

  def add_elements([], list2), do: list2

  def add_elements([h | tail], list2) do
    list2 = add_element(h, list2)
    add_elements(tail, list2)
  end

  def problem(n) do
    1..n
    |> Enum.to_list()
    |> add_elements([])
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end
end
