defmodule Problem43 do
  @moduledoc """
  https://projecteuler.net/problem=43

  Sub-string divisibility

  The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of
  the digits 0 to 9 in some order, but it also has a rather interesting sub-string
  divisibility property.

  Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

      d2d3d4=406 is divisible by 2
      d3d4d5=063 is divisible by 3
      d4d5d6=635 is divisible by 5
      d5d6d7=357 is divisible by 7
      d6d7d8=572 is divisible by 11
      d7d8d9=728 is divisible by 13
      d8d9d10=289 is divisible by 17

  Find the sum of all 0 to 9 pandigital numbers with this property.


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    time_start = Time.utc_now    # start chrono

    result = sub_string_div()

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : "
    IO.inspect result
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec"
  end

  @doc """
  """
  def sub_string_div() do
    for d1 <- ~w(0 1 2 3 4 5 6 7 8 9)  do
      for d2 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1] do
        for d3 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1, d2] do
          for d4 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1, d2, d3] do
            for d5 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1, d2, d3, d4] do
              for d6 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1, d2, d3, d4, d5] do
                for d7 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1, d2, d3, d4, d5, d6] do
                  for d8 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1, d2, d3, d4, d5, d6, d7] do
                    for d9 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1, d2, d3, d4, d5, d6, d7, d8] do
                      for d10 <- ~w(0 1 2 3 4 5 6 7 8 9) -- [d1, d2, d3, d4, d5, d6, d7, d8, d9] do
                        l = [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10]
                        if is_sub_divisible?(l) do
                            l
                            |> Enum.join
                            |> String.to_integer
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end 
    |> List.flatten
    |> Enum.uniq
    |> Enum.sort
    |> Enum.filter(fn x -> x != nil end)
    |> IO.inspect
    |> Enum.sum
  end
  def is_sub_divisible?([_d1, d2, d3, d4, d5, d6, d7, d8, d9, d10]) do
    do_is_divisible?([d2,d3,d4],2) &&
    do_is_divisible?([d3,d4,d5],3) &&
    do_is_divisible?([d4,d5,d6],5) &&
    do_is_divisible?([d5,d6,d7],7) &&
    do_is_divisible?([d6,d7,d8],11) &&
    do_is_divisible?([d7,d8,d9],13) &&
    do_is_divisible?([d8,d9,d10],17)
  end
  def do_is_divisible?(list,p) do
    n = 
      list
      |> Enum.join("") 
      |> String.to_integer
    rem(n,p) == 0
  end
end

