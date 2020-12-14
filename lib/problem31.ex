defmodule Coin do
  defstruct face: nil, value: nil, nb_max: nil
end

defmodule Euler.Problem31 do
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
    # start chrono
    time_start = Time.utc_now()

    result = coin_sums()

    # stop chrono
    time_finish = Time.utc_now()
    time_sec = Time.diff(time_finish, time_start)

    time_msec =
      Time.diff(time_finish, time_start, :microsecond)
      |> rem(1_000_000)
      |> div(1000)

    IO.puts("Result         : #{result}")
    IO.puts("Execution time : #{time_sec}sec,  #{time_msec} msec")
  end

  # main

  def coin_sums() do
    for i200 <- 0..1 do
      for i100 <- 0..(2 - i200 * 2) do
        for i50 <- 0..(4 - i200 * 4 - i100 * 2) do
          for i20 <- 0..(10 - i200 * 10 - i100 * 5 - i50 * 2) do
            for i10 <- 0..(20 - i200 * 20 - i100 * 10 - i50 * 5 - i20 * 2) do
              for i5 <- 0..(40 - i200 * 40 - i100 * 20 - i50 * 10 - i20 * 4 - i10 * 2) do
                for i2 <-
                      0..(100 - i200 * 100 - i100 * 50 - i50 * 25 - i20 * 10 - i10 * 5 - i5 * 2) do
                  i1 =
                    200 -
                      i200 * 200 -
                      i100 * 100 -
                      i50 * 50 -
                      i20 * 20 -
                      i10 * 10 -
                      i5 * 5 -
                      i2 * 2

                  if i1 >= 0 and i2 >= 0 and i5 >= 0 and i10 >= 0 and i20 >= 0 and
                       i50 >= 0 and i100 >= 0 and i200 >= 0 do
                    total =
                      i200 * 200 +
                        i100 * 100 +
                        i50 * 50 +
                        i20 * 20 +
                        i10 * 10 +
                        i5 * 5 +
                        i2 * 2 +
                        i1

                    {i200, i100, i50, i20, i10, i5, i2, i1, total}
                  end
                end

                # for i2
              end

              # for i5
            end

            # for i10
          end

          # for i20
        end

        # for i50
      end

      # for i100
    end

    # for i200
    |> List.flatten()
    |> Enum.sort()
    |> Enum.uniq()
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.count()
  end

  # coin_sums 
end

# module

#   coins = [
#     %Coin{ face: "£2", value: 200, nb_max: 1 },
#     %Coin{ face: "£1", value: 100, nb_max: 2 },
#     %Coin{ face: "50p", value: 50, nb_max: 4 },
#     %Coin{ face: "20p", value: 20, nb_max: 10 },
#     %Coin{ face: "10p", value: 10, nb_max: 20 },
#     %Coin{ face: "5p", value: 5, nb_max: 40 },
#     %Coin{ face: "2p", value: 2, nb_max: 100 },
#     %Coin{ face: "1p", value: 1, nb_max: 200 },
#     ]
