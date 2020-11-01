defmodule Euler_pb1_Test do
  use ExUnit.Case
  doctest Euler

  test "calculates the sum of multiples of 3 and 5 smaller than n" do
     assert Euler_pb1.sum_of_mult_of_3_5(1000) == 233168
     assert Euler_pb1.fast_sum_of_mult_of_3_5(1000) == 233168
     assert Euler_pb1.fast_sum_of_mult_of_3_5(10_000) == Euler_pb1.sum_of_mult_of_3_5(10_000)
  end
end
