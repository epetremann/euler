defmodule Euler.Problem39 do
  @moduledoc """
  https://projecteuler.net/problem=39

  Integer right triangles

  If p is the perimeter of a right angle triangle with integral length sides, {a,b,c},
  there are exactly three solutions for p = 120.

    {20,48,52}, {24,45,51}, {30,40,50}

  For which value of p ≤ 1000, is the number of solutions maximised?


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  # def main(fun_test \\ &pandigital_multiples/1 , 
  #          param \\ 1_000_000) do
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = integer_right_triangles(1000)

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
  def integer_right_triangles(n \\ 1_000) do
    [{_a, _b, _c, p} | _tail] =
      for p <- 3..n do
        for a <- 1..(p - 1), b <- a..(p - 1) do
          c = p - (a + b)

          if a * a + b * b == c * c do
            IO.inspect({a, b, c, p})
            {a, b, c, p}
          else
            nil
          end
        end
        |> Enum.filter(fn x -> x != nil end)
      end
      |> Enum.max_by(fn l -> length(l) end)

    p
  end
end
