defmodule Euler.Problem17 do
  @moduledoc """
  https://projecteuler.net/problem=17

  Number Letters count


  If the numbers 1 to 5 are written out in words: one, two, three, four, 
  five, then there are 
    3 + 3 + 5 + 4 + 4 = 19 letters used in total.

  If all the numbers from 1 to 1000 (one thousand) inclusive were written 
  out in words, how many letters would be used?

  Note: Do not count spaces or hyphens. For example, 342 (three hundred and
  forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
  20 letters.
  The use of 'and' when writing out numbers is in compliance with British 
  usage.

  """

  @doc """
  """
  def number_letters_count(n \\ 1000) do
    for i <- 1..n do
      number_length(i)
    end
    |> Enum.sum()
  end

  # number_letters_count

  def number_test(n1, n2) do
    IO.inspect(number_to_word(n1))

    if n1 < n2 do
      number_test(n1 + 1, n2)
    end
  end

  def number_length(n) do
    n
    |> number_to_word
    |> length
  end

  # number_length
  def number_to_word(n) when n > 1000 or n < 1 do
    # ignore number that are beyond limit (1 .. 1000)
    ''
  end

  def number_to_word(n) do
    if n === 1_000 do
      'OneThousand'
    else
      units = rem(n, 10)
      tens = div(rem(n, 100), 10)
      hundreds = div(rem(n, 1_000), 100)

      hundreds_to_w(hundreds, tens, units)
    end

    # if
  end

  defp units_to_w(units) do
    words = %{
      0 => '',
      1 => 'One',
      2 => 'Two',
      3 => 'Three',
      4 => 'Four',
      5 => 'Five',
      6 => 'Six',
      7 => 'Seven',
      8 => 'Eight',
      9 => 'Nine'
    }

    words[units]
  end

  defp tens_to_w(tens, units) do
    words = %{
      10 => 'Ten',
      11 => 'Eleven',
      12 => 'Twelve',
      13 => 'Thirteen',
      14 => 'Fourteen',
      15 => 'Fifteen',
      16 => 'Sixteen',
      17 => 'Seventeen',
      18 => 'Eighteen',
      19 => 'Nineteen',
      20 => 'Twenty',
      30 => 'Thirty',
      40 => 'Forty',
      50 => 'Fifty',
      60 => 'Sixty',
      70 => 'Seventy',
      80 => 'Eighty',
      90 => 'Ninety'
    }

    case tens do
      0 -> units_to_w(units)
      1 -> words[tens * 10 + units]
      _ -> words[tens * 10] ++ units_to_w(units)
    end

    # case tens
  end

  # tens_to_w

  def hundreds_to_w(hundreds, tens, units) do
    hundreds_w = tens_to_w(tens, units)

    case hundreds do
      0 ->
        hundreds_w

      _ ->
        if hundreds_w == '' do
          units_to_w(hundreds) ++ 'Hundred'
        else
          units_to_w(hundreds) ++ 'Hundred' ++ 'And' ++ hundreds_w
        end
    end

    # case hundreds
  end

  # hundreds_to_w
end

# module
