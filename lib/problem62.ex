defmodule Problem62 do
  @moduledoc """
  https://projecteuler.net/problem=62

  Cubic permutations

  The cube, 41063625 (345**3), can be permuted to produce two other cubes: 
    - 56623104 (384**3) 
    - 66430125 (405**3) 

    In fact, 41063625 is the smallest cube which has exactly three permutations of its digitss
    which are also cube.

    Find the smallest cube for which exactly five permutations of its digits are cube.


  """

  @doc """
  The purpose of the `main` function is to measure the execution time of as
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

  @doc """
  
  """
  def solve(n1 \\ 100, n2 \\ 10_000), do: do_solve(n1, n2, %{})
  def do_solve(n,n2, cubes) do
    n_cube = n*n*n
    n_key = highest_perm(n_cube)
    cond do
      n > n2 -> cubes
      n <= n2 -> 
        new_cubes = 
        if Map.has_key?(cubes, n_key) do
          cubes |> Map.update!(n_key, fn clist -> [n_cube | clist] end)
        else
          cubes |> Map.put(n_key, [n_cube])
        end
        n_permutations = new_cubes[n_key]
        if Enum.count(n_permutations) >= 5 do
          n_permutations |> Enum.sort |> List.first
        else
          do_solve(n+1,n2, new_cubes)
        end
    end
  end

  def highest_perm(n) do
    n 
    |> Integer.digits
    |> Enum.sort(:desc)
    |> Integer.undigits
  end
end
