defmodule Problem26 do
  @moduledoc """
  https://projecteuler.net/problem=26

  Reciprocal cycles



  A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

      1/2	= 	0.5
      1/3	= 	0.(3)
      1/4	= 	0.25
      1/5	= 	0.2
      1/6	= 	0.1(6)
      1/7	= 	0.(142857)
      1/8	= 	0.125
      1/9	= 	0.(1)
      1/10	= 	0.1 

  Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. 
  It can be seen that 1/7 has a 6-digit recurring cycle.
  
  Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its i
  decimal fraction part.


  """

  @doc """


  """
  def reciprocal_cycles( dig_size \\ 1000) do
    big_c = ([?1] ++ for _i <- 1..dig_size, do: ?0)
    big_i = big_c |> List.to_integer
    d_cycles = for d <- 2..1000, do: {d,cycle_length(big_i,d)}
    d_cycles 
    |> Enum.sort_by(fn {_d,cycle_l} -> cycle_l end, :desc) 
    |> hd
  end

  def cycle_length(big_i, d) do
    s = div(big_i,d)|> Integer.to_string
    if String.length(s) > 5 do
      pattern = String.slice(s,-3..-1)
      (
        pattern <>
          (
          String.split(s, pattern)
          |> List.delete_at(0)
          |> hd
        ) 
      ) 
      |> String.length
    else
      0
    end
  end


end # module
