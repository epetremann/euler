defmodule Problem38 do
  @moduledoc """
  https://projecteuler.net/problem=38

  Pandigital multiples

  Take the number 192 and multiply it by each of 1, 2, and 3:

    192 × 1 = 192
    192 × 2 = 384
    192 × 3 = 576

  By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576
  the concatenated product of 192 and (1,2,3)

  The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the
  pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

  What is the largest 1 to 9 pandigital 9-digit number that can be formed as the
  concatenated product of an integer with (1,2, ... , n) where n > 1?
  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
# def main(fun_test \\ &pandigital_multiples/1 , 
#          param \\ 1_000_000) do
  def main() do
    time_start = Time.utc_now    # start chrono

    result = pandigital_multiples(0)

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{IO.inspect result}"
    IO.puts "Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec"
  end

  @doc """
  """
  def pandigital_multiples(_n) do
    for x <- Enum.to_list(2..98765)
    do 
      pan_mult(x)
    end 
    |> Enum.max

  end

  def pan_mult(n) do
    do_pan_mult(n,1,'')
  end
  def do_pan_mult(n,p,clist) do
    cond do
      clist != Enum.uniq(clist) || 
      ?0 in clist || 
        length(clist) > 9 -> 0
      length(clist) == 9 -> 
        IO.inspect{n,p,clist}
        List.to_integer(clist)
      true -> 
        do_pan_mult(n,p+1,clist ++ Integer.to_charlist(n*p))
    end
  end
end
