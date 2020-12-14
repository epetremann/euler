defmodule Euler.Problem67 do
  @moduledoc """
  https://projecteuler.net/problem=67

  Maximum path sum I



  By starting at the top of the triangle below and moving to adjacent numbers on
  the row below, the maximum total from top to bottom is 23.

                               3
                              7 4
                             2 4 6
                            8 5 9 3
                               
  That is, 3 + 7 + 4 + 9 = 23.

  Find the maximum total from top to bottom of the triangle below:

                          75
                         95 64
                        17 47 82
                       18 35 87 10
                      20 04 82 47 65
                     19 01 23 75 03 34
                    88 02 77 73 07 63 67
                   99 65 04 28 06 16 70 92
                  41 41 26 56 83 40 80 70 33
                 41 48 72 33 47 32 37 16 94 29
                53 71 44 65 25 43 91 52 97 51 14
               70 11 33 28 77 73 17 78 39 68 17 57
              91 71 52 38 17 14 91 43 58 50 27 29 48
             63 66 04 68 89 53 67 30 73 16 69 87 40 31
            04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

  Note: As there are only 16384 routes, it is possible to solve this problem by
  trying every route. However, Problem 67, is the same challenge with a triangle containing
  one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)

  """

  @doc """
  bla bla bla
  """
  def max_path_sum() do
    generate_tree()
    |> Enum.reduce([], fn list, acc -> sum_lists(acc, list) end)
    |> Enum.max()
  end

  def generate_tree() do
    {:ok, raw_input} = File.read("data/p067_triangle.txt")

    raw_input
    |> String.split("\n")
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(fn x -> string_to_integer_list(x) end)
  end

  def string_to_integer_list(input) do
    input
    |> String.split(" ")
    |> Enum.map(fn x -> String.to_integer(x) end)
  end

  def sum_lists(a_list, b_list) do
    a_pairs = ([0] ++ a_list ++ [0]) |> Enum.chunk_every(2, 1, :discard)

    for {[a1, a2], b1} <- Enum.zip([a_pairs, b_list]) do
      Enum.max([a1 + b1, a2 + b1])
    end
  end

  # sum_lists
end

# module
