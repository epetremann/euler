defmodule Problem16 do
  @moduledoc """
  https://projecteuler.net/problem=16

  Power digit sum

  

  215 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

  What is the sum of the digits of the number 21000?



  """

  @doc """


  """
  def power_digit_sum(n \\ 1000) do
    :math.pow(2,n) 
    |> ceil 
    |> to_charlist 
    |> Stream.map(fn x -> x - ?0 end) 
    |> Enum.sum
  end
end

