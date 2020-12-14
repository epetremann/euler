defmodule Euler.Problem66 do
  @moduledoc """
  https://projecteuler.net/problem=66

  Diophantine equation

  Consider quadratic Diophantine equations of the form:

  x2 – Dy2 = 1

  For example, when D=13, the minimal solution in x is 6492 – 13×1802 = 1.

  It can be assumed that there are no solutions in positive integers when D is square.

  By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the following:

      32 – 2×22 = 1
      22 – 3×12 = 1
      92 – 5×42 = 1
      52 – 6×22 = 1
      82 – 7×32 = 1

  Hence, by considering minimal solutions in x for D ≤ 7, the largest x is obtained when D=5.

  Find the value of D ≤ 1000 in minimal solutions of x for which the largest value of x is obtained.

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve(1_000)

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
  def solve(d_max \\ 1_000) do
    IO.inspect({:d_max, d_max})
    do_solve(1, d_max, 0)
  end

  def do_solve(d, dmax, xmax) when d >= dmax, do: xmax

  def do_solve(d, dmax, xmax) do
    IO.inspect(d)

    cond do
      is_square?(d) ->
        do_solve(d + 1, dmax, xmax)

      true ->
        x = solve_d(d)

        new_xmax =
          if x > xmax do
            IO.inspect({:d, d, :xmax, x})
            x
          else
            xmax
          end

        do_solve(d + 1, dmax, new_xmax)
    end
  end

  def solve_d(d) do
    if is_square?(d) do
      nil
    else
      r = :math.sqrt(d)
      i = floor(r)

      if r - i > 0 do
        # find the reciprocal of r-i
      end
    end
  end

  def first_square(d), do: do_first_square(d, 1)

  def do_first_square(d, i) do
    candidate = int_sqrt(1 + d * i * i)

    if candidate != nil do
      candidate
    else
      do_first_square(d, i + 1)
    end
  end

  def int_sqrt(n), do: do_int_sqrt(n, 1)

  def do_int_sqrt(n, i) do
    i_square = i * i

    cond do
      i_square < n -> do_int_sqrt(n, i + 1)
      i_square > n -> nil
      i_square == n -> i
    end
  end

  def is_square?(n), do: do_is_square?(n, 1)

  def do_is_square?(n, i) do
    i_square = i * i

    cond do
      i_square < n -> do_is_square?(n, i + 1)
      i_square > n -> false
      i_square == n -> true
    end
  end
end
