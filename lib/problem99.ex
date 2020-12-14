defmodule Euler.Problem99 do
  @moduledoc """
  https://projecteuler.net/problem=99

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  example
  ## Examples
 
    iex> Euler.Problem99.main()
    :ok

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
  def solve(nmax \\ 2000) do
    {:ok, data} = File.read("data/p099_base_exp.txt")

    rank = data
    |> String.trim()
    |> String.split("\n")
    |> Enum.take(nmax)
    |> Enum.map(fn s ->
      s
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> Enum.with_index()
    |> Enum.reduce({{1, 1}, -1}, fn x, acc -> max_p(x, acc) end)
    |> elem(1)
    rank + 1
  end

  def max_p(
        {{base_1, exp_1}, _index_1} = var_1,
        {{base_2, exp_2}, _index_2} = var_2
      ) do
    # IO.inspect({:base_1, base_1, :base_2, base_2})
    v_1 = exp_1 * :math.log10(base_1)
    v_2 = exp_2 * :math.log10(base_2)

    if v_1 > v_2 do
      var_1
    else
      var_2
    end
  end

  def simplify(n) do
    n_list = Integer.digits(n)
    {List.first(n_list), length(n_list) - 1}
  end

  def pow(x, p, y, acc) do
    cond do
      acc > y ->
        acc

      p == 0 ->
        acc

      p > 1 ->
        x * pow(x, p - 1, y, acc * x)
    end
  end
end
