defmodule Euler_pb1 do
  @moduledoc """
  https://projecteuler.net/problem=1

  Multiples of 3 and 5


  Problem 1

  If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
  The sum of these multiples is 23.

  Find the sum of all the multiples of 3 or 5 below 1000.

  
  """

  @doc """
  Multiples of 3 and 5 smaller than n
  simple method not optimised


  """
  def sum_of_mult_of_3_5(n) do
    1..n-1
    |> Enum.filter(fn x -> rem(x,3)==0 || rem(x,5)==0 end)
    |> Enum.sum
  end

  def sum_of_mult_of(n,p) do
    n1 = div(n-1,p)
    p*div(n1*(n1+1),2)
  end

  def fast_sum_of_mult_of_3_5(n) do
    sum_of_mult_of(n,3) +
    sum_of_mult_of(n,5) -
    sum_of_mult_of(n,15)
  end

end
