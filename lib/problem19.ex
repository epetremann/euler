defmodule Euler.Problem19 do
  @moduledoc """
  https://projecteuler.net/problem=19


  Counting Sundays

    1 Jan 1900 was a Monday.
    Thirty days has September,
    April, June and November.
    All the rest have thirty-one,
    Saving February alone,
    Which has twenty-eight, rain or shine.
    And on leap years, twenty-nine.
    A leap year occurs on any year evenly divisible by 4, but not on a century unless it is
    divisible by 400.

    How many Sundays fell on the first of the month during the twentieth centurys
    (1 Jan 1901 to 31 Dec 2000)?

  """

  @doc """


  """
  def counting_sundays() do
    # For each year
    for year <- 1901..2000 do
      # For each month
      for month <- 1..12 do
        {:ok, d} = Date.new(year, month, 1)
        Date.day_of_week(d)
      end
      # 7 is Sunday
      |> Enum.count(fn x -> x == 7 end)
    end
    # Sum on all years
    |> Enum.sum()
  end
end

# module
