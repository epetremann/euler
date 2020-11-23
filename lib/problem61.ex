defmodule Problem61 do
  @moduledoc """
  https://projecteuler.net/problem=61

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of as
  function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve()

    # stop chrono
    time_finish = Time.utc_now()
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts("Result         : #{IO.inspect(result)}")
    IO.puts("Execution time : #{delta_sec}sec,  #{delta_msec}msec #{delta_micsec} microsec")
  end

  @doc """
  
  """
  def solve() do
    for a <- 10..99, 
      b <- Enum.to_list(10..99) -- [a],
      c <- Enum.to_list(10..99) -- [a,b],
      d <- Enum.to_list(10..99) -- [a,b,c],
      e <- Enum.to_list(10..99) -- [a,b,d],
      f <- Enum.to_list(10..99) -- [a,b,e]
    do
      cyclic_list = [
        a*100 + b,
        b*100 + c,
        c*100 + d,
        d*100 + e,
        e*100 + f,
        f*100 + a
      ]
      p3_list = 
        cyclic_list 
        |> Enum.filter(fn x -> find_pn(x,&p3/1) end)
      if length(p3_list) > 0 do
        p4_list = 
          (cyclic_list -- p3_list)
          |> Enum.filter(fn x -> find_pn(x,&p4/1) end)
        if length(p4_list) > 0 do
          p5_list = 
          (cyclic_list -- p3_list -- p4_list)
          |> Enum.filter(fn x -> find_pn(x,&p5/1) end)
          if length(p5_list) > 0 do
            p6_list =
              (cyclic_list -- p3_list -- p4_list -- p5_list)
              |> Enum.filter(fn x -> find_pn(x,&p6/1) end)
            if length(p6_list) > 0 do
              p7_list =
                (cyclic_list -- p3_list -- p4_list -- p5_list -- p6_list)
                |> Enum.filter(fn x -> find_pn(x,&p7/1) end)
              if length(p7_list) > 0 do
                p8_list =
                  (cyclic_list -- p3_list -- p4_list -- p5_list -- p6_list -- p7_list)
                  |> Enum.filter(fn x -> find_pn(x,&p8/1) end)
                if length(p8_list) > 0 do
                  IO.inspect cyclic_list
                end #p8
              end #p7
            end #p6
          end #p5
        end #p4
      end #p3
    end
    |> Enum.filter(&(&1))
  end

  @doc """
  Triangle 	  	P3,n=n(n+1)/2 	  	1, 3, 6, 10, 15, ...
  """
  def p3(n), do: n*(n+1) |> div(2)

  @doc """
  Square 	  	P4,n=n2 	  	1, 4, 9, 16, 25, ...
  """
  def p4(n), do: n*n

  @doc """
  Pentagonal 	  	P5,n=n(3n−1)/2 	  	1, 5, 12, 22, 35, ...
  """
  def p5(n), do: n*(3*n-1) |> div(2)
  
  @doc """
  Hexagonal 	  	P6,n=n(2n−1) 	  	1, 6, 15, 28, 45, ...
  """
  def p6(n), do:  n*(2*n-1)

  @doc """
  Heptagonal 	  	P7,n=n(5n−3)/2 	  	1, 7, 18, 34, 55, ...
  """
  def p7(n), do: n*(5*n-3) |> div(2)

  @doc """
  Octagonal 	  	P8,n=n(3n−2) 	  	1, 8, 21, 40, 65, ...
  """
  def p8(n), do: n*(3*n-2)

  @doc """
  is_pn?(&pn/1, n) searches for the smallest number x : pn(x) = n
  where pn is one of [p3, p4, p5, p6, p7, p8]
  if there is no such number, returns nil
  """
  def find_pn(n, pn), do: do_find_pn(n, pn, 1) 
  def do_find_pn(n, pn, i) do
    cond do
      pn.(i) > n -> nil
      pn.(i) == n -> i
      pn.(i) < n -> do_find_pn(n, pn, i+1)
    end
  end
end

