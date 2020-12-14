defmodule Euler.Problem71 do
  require Integer

  @moduledoc """
  https://projecteuler.net/problem=71

  Ordered fractions


  Consider the fraction, n/d, where n and d are positive integers.
  If n<d and HCF(n,d)=1, it is called a reduced proper fraction.

  If we list the set of reduced proper fractions for d ≤ 8 in ascending
  order of size, we get:

    1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 
    1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

  It can be seen that 2/5 is the fraction immediately to the left of 3/7.

  By listing the set of reduced proper fractions for d ≤ 1,000,000 in
  ascending order of size, find the numerator of the fraction immediately to the left of 3/7.
  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main(dmax \\ 8, {a, b} \\ {3, 7}) do
    # start chrono
    time_start = Time.utc_now()

    result = solve(dmax, {a, b})

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
  def solve(dmax, {a, b}) do
    {min_top, min_bottom} = {a, b + 1}
    do_solve(dmax, {a, b}, 1, {min_top, min_bottom})

    #     nmax = div(d*a,b)
    #     {min_top, min_bottom} = for n <- div(d*min_top,min_bottom)..nmax, is_coprime(n,d) and (n*dmax/d)<(a*dmax/(b)) do
    #     IO.inspect{:n,n,:d,d,  {min_top, min_bottom}}
    #       {n,d}
    #     end
    #     |> Enum.at(-1, {min_top, min_bottom})
    #   end
    #   |> Enum.filter(&(&1))
    #   |> Enum.sort_by(fn({a,b})->fraction({a*dmax,b}) end)
    #   |> Enum.at(-1)
  end

  def do_solve(dmax, {a, b}, d, {min_top, min_bottom}) do
    cond do
      d > dmax ->
        {min_top, min_bottom}

      d <= dmax ->
        nmax = div(d * a, b)

        {new_min_top, new_min_bottom} =
          for n <- div(d * min_top, min_bottom)..nmax,
              is_coprime(n, d) and n * dmax / d < a * dmax / b do
            {n, d}
          end
          |> Enum.at(-1, {min_top, min_bottom})

        {min_top, min_bottom} =
          [{new_min_top, new_min_bottom}, {min_top, min_bottom}]
          |> Enum.sort_by(fn {a, b} -> fraction({a * dmax, b}) end)
          |> Enum.at(-1)

        do_solve(dmax, {a, b}, d + 1, {min_top, min_bottom})
    end
  end

  def fraction({a, b}) do
    a / b
  end

  @doc """
  is_coprime?(a,b) returns true if the HCF of a and is 1.
  """
  def is_coprime(a, b) when is_integer(a) and is_integer(b) and b != 0 do
    (Integer.is_odd(a) or Integer.is_odd(b)) and hcf(a, b) == 1
  end

  @doc """
  fraction_is_smaller?({a,b},{c,d}) returns true 
  if {a,b} is smaller than {c,d}
  """
  def fraction_is_smaller?({a, b}, {c, d}) do
    a / b < c / d
  end

  @doc """
  the hcf function finds the highest common factor (HCF) of two
  integers by using the Euclid's division lemma method.
  """
  def hcf(a, b) when is_integer(a) and is_integer(b) and b != 0 do
    r = rem(a, b)

    if r == 0 do
      b
    else
      hcf(b, r)
    end
  end
end
