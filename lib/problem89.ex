defmodule Problem89 do
  @moduledoc """
  https://projecteuler.net/problem=89

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a
  function.
  """
  @numbers %{
      "M" => 1000,
      "D" => 500,
      "C" => 100,
      "L" => 50,
      "X" => 10,
      "V" => 5,
      "I" => 1
  }

  def main() do
    time_start = Time.utc_now    # start chrono

    result = solve()

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{IO.inspect result}"
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec"
  end
  def solve() do
    for s <- ~w(  M D C L X V I ) do
      IO.inspect {  s,  @numbers[s] }
    end
  end
end
