defmodule Euler.Problem2 do
  @moduledoc """
  https://projecteuler.net/problem=2

  Problem 2:
  Each new term in the Fibonacci sequence is generated by adding the previous two terms. 
  By starting with 1 and 2, the first 10 terms will be:

     1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

  By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
  find the sum of the even-valued terms.

  """

  @doc """
  Multiples of 3 and 5 smaller than n
  simple method not optimised


  """
  def fibonacci(0), do: []
  def fibonacci(1), do: [1]
  def fibonacci(2), do: [1, 2]
  def fibonacci(n), do: fibonacci([2, 1], n)

  def fibonacci([b, a | tail], n) do
    if a + b > n do
      [b, a | tail] |> Enum.reverse()
    else
      fibonacci([a + b, b, a | tail], n - 1)
    end
  end

  def sum_of_even_fibonacci(n) do
    fibonacci(n)
    |> Enum.filter(fn x -> rem(x, 2) == 0 end)
    |> Enum.sum()
  end
end
