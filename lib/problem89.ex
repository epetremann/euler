defmodule Roman.Time, do: defstruct s_input: "", value: 0
defmodule Problem89 do

  @moduledoc """
  https://projecteuler.net/problem=67


  Roman numerals


  For a number written in Roman numerals to be considered valid there are basic rules which must be followed.
  Even though the rules allow some numbers to be expressed in more than one way there is always a "best" way of writing a particular number.

  For example, it would appear that there are at least six ways of writing the number sixteen:

        IIIIIIIIIIIIIIII
        VIIIIIIIIIII
        VVIIIIII
        XIIIIII
        VVVI
        XVI

  However, according to the rules only XIIIIII and XVI are valid, and the last example is considered to be the most efficient,
  as it uses the least number of numerals.

  The 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains one thousand numbers written in valid,
  but not necessarily minimal, Roman numerals; see About... Roman Numerals for the definitive rules for this problem.

  Find the number of characters saved by writing each of these in their minimal form.

  Note: You can assume that all the Roman numerals in the file contain no more than four consecutive identical units.
  """

  def main() do
    time_start = Time.utc_now    # start chrono

    result = solve()

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{IO.inspect result}"
    IO.puts "Execution time : #{delta_sec} s,  #{delta_msec} ms #{delta_micsec} micros"
  end #main

  def solve(filepath \\ "./data/p089_roman.txt") do
    {:ok, data} = File.read(filepath)
    data
    |> String.trim
    |> String.split("\n")
    |> Enum.reduce(0, fn(x, acc) -> acc + roman_simplify(x) end)
  end

  def roman_simplify(s) do
    String.length(s) - (
    s
    |> roman_decode
    |> roman_encode
    |> String.length
    )
  end

  def roman_encode(n),  do: roman_encode(n, "")
  def roman_encode(n, s) do
    cond do
      n >= 1000 -> roman_encode(rem(n,1000), s <> String.duplicate("M",div(n,1000)))
      n >= 100  -> roman_encode(rem(n,100),  s <> arrange(div(n,100), "C","D","M"))
      n >= 10   -> roman_encode(rem(n,10),  s <> arrange(div(n,10), "X","L","C"))
      n <  10   ->  s <> arrange(n, "I","V","X")
      true -> "" <> s
    end
  end

  def arrange(x, unit, penta, deca) do
    case x do
      9 -> unit <> deca
      8 -> penta <> unit <> unit <> unit
      7 -> penta <> unit <> unit
      6 -> penta <> unit
      5 -> penta
      4 -> unit <> penta
      3 -> unit <> unit <> unit
      2 -> unit <> unit
      1 -> unit
      0 -> ""
    end
  end

    def roman_pattern(p) do
    %{
      "CCM" => 800,
      "CM"  => 900,
      "M"   => 1000,
      "CD"  => 400,
      "D"   => 500,
      "XXC" => 80,
      "XC"  => 90,
      "C"   => 100,
      "XL"  => 40,
      "L"   => 50,
      "IIX" => 8,
      "IX"  => 9,
      "X"   => 10,
      "IV"  => 4,
      "V"   => 5,
      "I"   => 1
    }[p]
  end

    def roman_decode(s \\ "MMCMLXXVI") do
      (%Roman.Time{ s_input: s }
      |> decode("CCM")
      |> decode("CM")
      |> decode("M")
      |> decode("CD")
      |> decode("D")
      |> decode("XXC")
      |> decode("XC")
      |> decode("C")
      |> decode("XL")
      |> decode("L")
      |> decode("IIX")
      |> decode("IX")
      |> decode("X")
      |> decode("IV")
      |> decode("V")
      |> decode("I")).value
  end

  def decode(%Roman.Time{s_input: s_input,  value: value}, pattern ) do
    count =
      (String.split(s_input, pattern)
      |> Enum.count) -1
    value = roman_pattern(pattern) * count + value
    s_input = String.replace(s_input, pattern, "")
    %Roman.Time{s_input: s_input,  value: value}
  end
end # module
