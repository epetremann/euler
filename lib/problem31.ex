defmodule Coin do
  defstruct face: nil, value: nil
end
defmodule Problem31 do
  @moduledoc """
  https://projecteuler.net/problem=31
  
  Coin sums

  In the United Kingdom the currency is made up of pound (£) and pence (p).   There are eight coins in general circulation:

    1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).

  It is possible to make £2 in the following way:

    1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

  How many different ways can £2 be made using any number of coins?

  """

  def main() do
    time_start = Time.utc_now    # start chrono

    result = coin_sums()

    time_finish = Time.utc_now   # stop chrono
    time_sec = Time.diff(time_finish, time_start)
    time_msec =
      Time.diff(time_finish, time_start, :microsecond)
      |> rem(1_000_000)
      |> div(1000)

    IO.puts "Result         : #{result}"
    IO.puts "Execution time : #{time_sec}sec,  #{time_msec} msec"
  end #main

  def coin_sums() do
#   coins = [
#     %Coin{ face: "£2", value: 200 },
#     %Coin{ face: "£1", value: 100 },
#     %Coin{ face: "50p", value: 50 },
#     %Coin{ face: "20p", value: 50 },
#     %Coin{ face: "10p", value: 50 },
#     %Coin{ face: "5p", value: 5 },
#     %Coin{ face: "2p", value: 2 },
#     %Coin{ face: "1p", value: 1 },
    #   ]
  end

  # How many ways to make 5p with 2p and 1p coins: n=3
  # 1 : 1 + 1 + 1 + 1
  # 2 : 1 + 1 + 2
  # 3 : 1 + 2 + 2
  # How namy ways to make 10 p with 5p, 2p and 1p coins: 
  #  1 + 3 + (n + k - 1)!/k!(n-1)  with n=3, k=2 
  #  1 : 5 + 5
  #  2 : 5 + 1 + 1 + 1 + 1
  #  3 : 5 + 1 + 1 + 2
  #  4 : 5 + 1 + 2 + 2
  #  5 : 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1
  #  6 : 1 + 1 + 1 + 1 + 1 + 1 + 2
  #  7 : 1 + 1 + 1 + 1 + 1 + 2 + 2
  #  8 : 1 + 1 + 2 + 1 + 1 + 2
  #  9 : 1 + 1 + 2 + 1 + 2 + 2
  # 10 : 1 + 2 + 2 + 1 + 2 + 2
  
  def combination_with_repeat(n,k) do
    div(fact(n+k-1),fact(k)*fact(n-1))
  end

  def fact(n) do
    case n do
      0 -> 1
      _ -> n*fact(n-1)
    end
  end
end #module

