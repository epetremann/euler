defmodule Euler.Problem22 do
  @moduledoc """
  https://projecteuler.net/problem=22

  Name scores

  Using names.txt (https://projecteuler.net/project/resources/p022_names.txt)
  a 46K text file containing over five-thousand first names, begin by sorting 
  it into alphabetical order. Then working out the alphabetical value for each 
  name, multiply this value by its alphabetical position in the list to obtain 
  a name score.

  For example, when the list is sorted into alphabetical order, 
  COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, 
  is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.

  What is the total of all the name scores in the file?


  """

  @doc """


  """

  def name_scores(names_file \\ "data/p022_names.txt") do
    {:ok, names_string} = File.read(names_file)

    names_list =
      names_string
      |> String.replace("\"", "")
      |> String.split(",")
      |> Enum.sort()
      |> Enum.map(&to_number(&1))

    names_number = length(names_list)

    Stream.zip(1..names_number, names_list) |> Enum.reduce(0, fn {a, b}, acc -> a * b + acc end)
  end

  # name_scores

  def to_number(name) do
    name
    # convert to list of char 
    |> String.to_charlist()
    # convert ito value (?@=64, ?A=65)
    |> Enum.map(&(&1 - ?@))
    # sum
    |> Enum.sum()
  end
end

# module
