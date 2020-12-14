defmodule Euler.Problem28 do
  @moduledoc """
  https://projecteuler.net/problem=28

  Number spiral diagonals


  Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

  21 22 23 24 25
  20  7  8  9 10
  19  6  1  2 11
  18  5  4  3 12
  17 16 15 14 13

  It can be verified that the sum of the numbers on the diagonals is 101.

  What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?

          73 74 75 76 77 78 79 80 81
          72 43 44 45 46 47 48 49 50
          71 42 21 22 23 24 25 26 51
          70 41 20  7  8  9 10 27 52
          69 40 19  6  1  2 11 28 53
          68 39 18  5  4  3 12 29 54
          67 38 17 16 15 14 13 30 55
          66 37 36 35 34 33 32 31 56
          65 64 63 62 61 60 59 58 57


  """

  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = number_spiral_diagonals(1001)

    # stop chrono
    time_finish = Time.utc_now()

    IO.puts("Result         : #{result}")
    IO.puts("Execution time : #{Time.diff(time_finish, time_start)}s")
  end

  # main

  def number_spiral_diagonals(n) when rem(n, 2) == 1 do
    number_spiral_diagonals(n, [1], 2)
    |> Enum.sum()
  end

  def number_spiral_diagonals(n, [h | tail], step) do
    cond do
      step + 1 > n ->
        [h | tail]

      true ->
        number_spiral_diagonals(
          n,
          [h + step * 4, h + step * 3, h + step * 2, h + step, h | tail],
          step + 2
        )
    end
  end
end

# module
