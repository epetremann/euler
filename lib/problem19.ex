defmodule Problem19 do

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
    for year <- 1901..2000 do      # For each year
      for month <- 1..12 do        # For each month
        {:ok, d} = Date.new(year, month, 1)  
        Date.day_of_week(d)       
      end |> Enum.count(fn x -> x==7 end) # 7 is Sunday
    end |> Enum.sum     # Sum on all years
  end   

end # module
