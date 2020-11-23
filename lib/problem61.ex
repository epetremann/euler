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
  def solve(n1 \\ 1000, n2 \\ 9999) do
    plist3 = get_pnlist(n1, n2, &p3/1)
    plist4 = get_pnlist(n1, n2, &p4/1)
    plist5 = get_pnlist(n1, n2, &p5/1)
    plist6 = get_pnlist(n1, n2, &p6/1)
    plist7 = get_pnlist(n1, n2, &p7/1)
    plist8 = get_pnlist(n1, n2, &p8/1)

    all_numbers_list = [ plist3, plist4, plist5, plist6, plist7, plist8 ]
    for l1 <- [ plist3, plist4, plist5, plist6, plist7, plist8 ] do
      for l2 <- (all_numbers_list -- [l1]) do
        for l3 <- (all_numbers_list -- [l1, l2]) do
          for l4 <- (all_numbers_list -- [l1, l2, l3]) do
            for l5 <- (all_numbers_list -- [l1, l2, l3, l4]) do
              for l6 <- (all_numbers_list -- [l1, l2, l3, l4, l5]) do
                    get_suites(l1, l2, l3, l4, l5, l6 )
              end
            end
          end
        end
      end
    end
    |> List.flatten
  end

  @doc """
  generates all 4-digits suites from two lists
  """
  def get_suites(l1, l2, l3, l4, l5, l6) do
      for px1 <- l1,
        px2 <- (l2 |> Enum.filter(fn x -> rem(px1,100) == div(x,100) end)), 
        px3 <- (l3 |> Enum.filter(fn x -> rem(px2,100) == div(x,100) end)), 
        px4 <- (l4 |> Enum.filter(fn x -> rem(px3,100) == div(x,100) end)), 
        px5 <- (l5 |> Enum.filter(fn x -> rem(px4,100) == div(x,100) end)), 
        px6 <- (l6 |> Enum.filter(fn x -> rem(px5,100) == div(x,100) && rem(x,100) == div(px1,100)end)) do 
          { Enum.sum([px1, px2, px3, px4, px5, px6]), [px1, px2, px3, px4, px5, px6]}
    end 
  end


  @doc """
  Triangle 	 	P3,n=n(n+1)/2 	 	1, 3,  6, 10, 15, ...
  Square 	  	P4,n=n2 	  	    1, 4,  9, 16, 25, ...
  Pentagonal 	P5,n=n(3n−1)/2 	 	1, 5, 12, 22, 35, ...
  Hexagonal  	P6,n=n(2n−1) 	  	1, 6, 15, 28, 45, ...
  Heptagonal 	P7,n=n(5n−3)/2 	 	1, 7, 18, 34, 55, ...
  Octagonal  	P8,n=n(3n−2) 	  	1, 8, 21, 40, 65, ...
  """
  def p3(n), do: n*(n+1) |> div(2)
  def p4(n), do: n*n
  def p5(n), do: n*(3*n-1) |> div(2)
  def p6(n), do: n*(2*n-1)
  def p7(n), do: n*(5*n-3) |> div(2)
  def p8(n), do: n*(3*n-2)



  @doc """
  lis_pn(n1,n2, pn) generates a list of all pn (triangle, square etc.) numbers comprised between
  n1 and n2 : n1 <= pn(n) <= n1.
  """
  def get_pnlist(n1, n2, func_pn), do: do_get_pnlist(n1, n2, func_pn, 1, [])
  def do_get_pnlist(n1, n2, func_pn, i, pnlist) do
    pni = func_pn.(i)
    cond do
      pni > n2 -> pnlist
      pni < n1 -> do_get_pnlist(n1, n2, func_pn, i+1, pnlist)
      pni >= n1 and 
      pni <= n2 -> do_get_pnlist(n1, n2, func_pn, i+1, [pni | pnlist])
    end
  end
end
