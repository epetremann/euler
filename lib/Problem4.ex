defmodule Euler4 do
  @moduledoc """
  https://projecteuler.net/problem=4

  Problem 4:



  """

  @doc """


  """

  def is_palindrom(n) when is_integer(n) do
    n |> Integer.to_string() |> is_palindrom
  end

  def is_palindrom(s) when is_bitstring(s) do
    if String.reverse(s) == s do
      IO.puts(s)
      true
    else
      false
    end
  end

  def is_palindrom(x, y) do
    IO.puts("#{x} #{y}")
    is_palindrom(x * y)
  end

  def mirror(n) do
    s = Integer.to_string(n)
    (s <> String.reverse(s)) |> String.to_integer()
  end

  def find_factor_of(_big_number, current_number, _start, finish, _step)
      when current_number < finish do
    {nil, nil}
  end

  def find_factor_of(big_number, current_number, start, finish, step) do
    # IO.inspect {big_number, current_number, start, finish, step}
    if rem(big_number, current_number) == 0 do
      fact2 = div(big_number, current_number) |> ceil

      if fact2 <= start and fact2 >= finish do
        {current_number, fact2}
      else
        {nil, nil}
      end
    else
      find_factor_of(big_number, current_number - step, start, finish, step)
    end
  end

  def biggest_palindrom_of_two_numbers_of_size(current_n1, _start, finish)
      when current_n1 < finish do
    nil
  end

  def biggest_palindrom_of_two_numbers_of_size(current_n1, start, finish) do
    big_number = mirror(current_n1)
    step = 11
    factors = find_factor_of(big_number, start - rem(start, step), start, finish, step)

    if factors != {nil, nil} do
      {big_number, factors}
    else
      biggest_palindrom_of_two_numbers_of_size(current_n1 - 1, start, finish)
    end
  end

  def biggest_palindrom_of_two_numbers_of_size(n) do
    start = ceil(:math.pow(10, n)) - 1
    finish = ceil(:math.pow(10, n - 1))
    biggest_palindrom_of_two_numbers_of_size(start, start, finish)
  end
end
