defmodule Problem60 do
  @moduledoc """
  https://projecteuler.net/problem=60

  Prime pair sets
  
  The primes 3, 7, 109, and 673, are quite remarkable.
  By taking any two primes and concatenating them in any order the result will always be prime.
  For example, taking 7 and 109, both 7109 and 1097 are prime.
  The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.

  Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    # start chrono
    time_start = Time.utc_now()

    result = solve(10_000)

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
  def solve(nmax \\  10_000) do
    primes = 2..nmax |> Enum.filter(&is_prime?/1)
    imax = Enum.count(primes) -1
    for index1 <- 0..imax-4 do 
      p1 = Enum.at(primes, index1)
      for index2 <- index1+1..imax-3 do 
        p2 = Enum.at(primes, index2)
        if is_concatenate_prime?(p1,p2) do
          for index3 <- index2+1..imax-2 do 
            p3 = Enum.at(primes, index3)
            if is_concatenate_prime?(p1,p3) &&
               is_concatenate_prime?(p2,p3) do
              for index4 <- index3+1..imax-1 do 
                p4 = Enum.at(primes, index4)
                if is_concatenate_prime?(p1,p4) &&
                   is_concatenate_prime?(p2,p4) &&
                   is_concatenate_prime?(p3,p4) do
                  for index5 <- index4+1..imax do 
                    p5 = Enum.at(primes, index5)
                    if is_concatenate_prime?(p1,p5) &&
                       is_concatenate_prime?(p2,p5) &&
                       is_concatenate_prime?(p3,p5) &&
                       is_concatenate_prime?(p4,p5) do
                       result_list = [p1,p2,p3,p4,p5]
                       sum_list = Enum.sum(result_list)
                      IO.inspect {sum_list, result_list}
                      {sum_list, result_list}
                    end # if p5
                  end # for index5
                end #if p4
              end # for index4
            end # if p3
          end
        end
      end
    end
    |> List.flatten
  end

  def is_concatenate_prime?(a,b) do
    is_prime?(concatenate(a,b)) and is_prime?(concatenate(b,a))
  end
  def concatenate(a,b) do
    Integer.digits(a) ++ Integer.digits(b) 
    |> Integer.undigits
  end

    
  def is_prime?(n) do
    cond do
      n <= 1 ->
        false

      n in [2, 3, 5, 7, 11, 13] ->
        true

      rem(n, 2) == 0 ->
        false

      true ->
        max_factor = n |> :math.sqrt() |> ceil
        do_is_prime?(n, 3, max_factor)
    end
  end

  def do_is_prime?(n, factor, max_factor) do
    cond do
      factor > max_factor ->
        true

      rem(n, factor) == 0 ->
        false

      true ->
        do_is_prime?(n, factor + 2, max_factor)
    end
  end
end
