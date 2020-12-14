defmodule Euler.Problem98 do
  @moduledoc """
  https://projecteuler.net/problem=98

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
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
  def solve() do
    {:ok, data} = File.read("data/p098_words.txt")

    words =
      data
      |> String.trim()
      |> String.replace("\"", "")
      |> String.split(",")

    len = length(words)

    for i <- 0..(len - 2), j <- (i + 1)..(len - 1) do
      word1 = Enum.at(words, i)
      word2 = Enum.at(words, j)

      if String.length(word1) == String.length(word2) and
           Enum.sort(String.graphemes(word1)) == Enum.sort(String.graphemes(word2)) do
        IO.inspect({word1, word2})
      end
    end
    |> Enum.filter(& &1)
  end
end
