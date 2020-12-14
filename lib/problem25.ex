defmodule Euler.Problem25 do
  @moduledoc """
  https://projecteuler.net/problem=25

  1000-digit Fibonacci number

  The Fibonacci sequence is defined by the recurrence relation:

      Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.

  Hence the first 12 terms will be:

        F1 = 1
        F2 = 1
        F3 = 2
        F4 = 3
        F5 = 5
        F6 = 8
        F7 = 13
        F8 = 21
        F9 = 34
        F10 = 55
        F11 = 89
        F12 = 144

  The 12th term, F12, is the first term to contain three digits.

  What is the index of the first term in the Fibonacci sequence to
  contain 1000 digits?

  """

  @doc """


  """
  def fibonacci_1000_digits(dig_size \\ 10) do
    fibonacci(1, 1, 2, dig_size)
  end

  def fibonacci(a, b, index, dig_size) do
    {a, b, index} = {a + b, a, index + 1}

    if length(Integer.to_charlist(a)) >= dig_size do
      {a, index}
    else
      fibonacci(a, b, index, dig_size)
    end
  end
end

# module
