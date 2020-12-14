defmodule Euler.Problem75 do
  @moduledoc """
  https://projecteuler.net/problem=75

  Singular integer right triangles

  It turns out that 12 cm is the smallest length of wire that can be bent to form an integer sided right angle triangle in exactly one way, but there are many more examples.

    12 cm: (3,4,5)
    24 cm: (6,8,10)
    30 cm: (5,12,13)
    36 cm: (9,12,15)
    40 cm: (8,15,17)
    48 cm: (12,16,20)

  In contrast, some lengths of wire, like 20 cm, cannot be bent to form an integer sided right angle triangle, and other lengths allow more than one solution to be found; for example, using 120 cm it is possible to form exactly three different integer sided right angle triangles.

      120 cm: (30,40,50), (20,48,52), (24,45,51)

  Given that L is the length of the wire, for how many values of L ≤ 1,500,000 can exactly one integer sided right angle triangle be formed?


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve()

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : #{IO.inspect(result)}")
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec")
  end

  def solve(n_max \\ 1_500_000) do
    do_solve(12, 0, n_max)
  end

  def do_solve(n, count, n_max) do
    cond do
      n > n_max ->
        count

      find_solutions(n) == 1 ->
        IO.inspect({n, count})
        do_solve(n + 1, count + 1, n_max)

      true ->
        do_solve(n + 1, count, n_max)
    end
  end

  def find_solutions(l) do
    for a <- 1..(l - 2), b <- (a + 1)..(l - 1) do
      c = l - a - b

      if c * c == a * a + b * b do
        {a, b, c}
      end
    end
    |> Enum.filter(& &1)
    |> Enum.count()
  end
end
