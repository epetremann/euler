defmodule Euler.Problem14 do
  @moduledoc """
  https://projecteuler.net/problem=13

  Longest Collatz sequence


  The following iterative sequence is defined for the set of positive 
  integers:
         n → n/2 (n is even)
         n → 3n + 1 (n is odd)

  Using the rule above and starting with 13, we generate the following 
  sequence:
         13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

  It can be seen that this sequence (starting at 13 and finishing at 1) 
  contains 10 terms.
  Although it has not been proved yet (Collatz Problem), it is thought 
  that all starting numbers finish at 1.

  Which starting number, under one million, produces the longest chain?

  Note:  Once the chain starts the terms are allowed to go above one 
  million.


  """

  @doc """


  """

  def longest_collatz_sequence(big_number \\ 999_999) do
    longest_collatz_sequence(big_number, 0, 0)
  end

  def longest_collatz_sequence(0, max_starting, max_sequence) do
    {max_starting, max_sequence}
  end

  def longest_collatz_sequence(big_number, max_starting, max_sequence) do
    sequence = collatz_sequence_length(big_number)

    # IO.inspect({ :big_number, big_number, :sequence, sequence, :max_starting, max_starting, :max_sequence, max_sequence } )
    if sequence > max_sequence do
      longest_collatz_sequence(big_number - 1, big_number, sequence)
    else
      longest_collatz_sequence(big_number - 1, max_starting, max_sequence)
    end
  end

  def collatz_sequence(n) do
    collatz_sequence(n, [])
  end

  def collatz_sequence(n, list) when n <= 1 do
    [1 | list] |> Enum.reverse()
  end

  def collatz_sequence(n, list) do
    result =
      if rem(n, 2) == 0 do
        collatz_sequence(div(n, 2), [n | list])
      else
        collatz_sequence(3 * n + 1, [n | list])
      end

    result
  end

  def collatz_sequence_length(n) do
    collatz_sequence(n) |> length
  end
end
