defmodule Problem32 do
  @moduledoc """
  https://projecteuler.net/problem=32
  
  Pandigital products

  We shall say that an n-digit number is pandigital if it makes use of all
  the digits 1 to n exactly once; for example, the 5-digit number,
  15234, is 1 through 5 pandigital.

  The product 7254 is unusual, as the identity, 39 × 186 = 7254,
  containing multiplicand, multiplier, and product is 1 through 9
  pandigital.

  Find the sum of all products whose multiplicand/multiplier/product
  identity can be written as a 1 through 9 pandigital.
  HINT: Some products can be obtained in more than one way so be sure to
  only include it once in your sum.


  """

  def main() do
    time_start = Time.utc_now    # start chrono

    result = pandigital_products()

    time_finish = Time.utc_now   # stop chrono
    time_sec = Time.diff(time_finish, time_start)
    time_msec =
      Time.diff(time_finish, time_start, :microsecond)
      |> rem(1_000_000)
      |> div(1000)

    IO.puts "Result         : #{result}"
    IO.puts "Execution time : #{time_sec}sec,  #{time_msec} msec"
  end #main

  def pandigital_products() do
    #max_number = 987_654_321
    for x <- 1..100,  y <- x..100_000 do
      if is_pandigital_prod?(x,y) do
        IO.inspect {x,y,x*y}
        x*y
      else
        0
      end 
    end
    |> Enum.uniq
    |> Enum.sum
  end

    def is_pandigital_prod?(a,b) do
      p_digits = 
        (
          Integer.to_charlist(a) 
          ++ Integer.to_charlist(b) 
          ++ Integer.to_charlist(a*b) 
        )
        |> Enum.sort
      p_digits == '123456789'
    end

end #module

