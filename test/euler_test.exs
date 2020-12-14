defmodule Euler_Test do
  use ExUnit.Case
  doctest Euler.Problem99

  test "calculates the sum of multiples of 3 and 5 smaller than n" do
    assert Euler.Problem1.sum_of_mult_of_3_5(1000) == 233_168
  end
end
