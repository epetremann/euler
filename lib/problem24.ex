defmodule Euler.Problem24 do
  @moduledoc """
  https://projecteuler.net/problem=24

  Lexicographic permutations

  A permutation is an ordered arrangement of objects. For example, 3124 is one possible
  permutation of the digits 1, 2, 3 and 4.
  If all of the permutations are listed numerically or alphabetically, we call it
  lexicographic order.
  The lexicographic permutations of 0, 1 and 2 are:

       012   021   102   120   201   210

   What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

  """

  @doc """


  """
  def lexicographic_permutations(digits \\ '0123456789', position \\ 1_000_000) do
    range = position - 1
    perm(digits) |> Enum.at(range)
  end

  def perm([]) do
    [[]]
  end

  def perm(digits) do
    for h <- digits, t <- perm(digits -- [h]), do: [h | t]
  end
end

# module
