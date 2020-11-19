defmodule Problem59 do
  @moduledoc """
  https://projecteuler.net/problem=59


  XOR description

  

  Each character on a computer is assigned a unique code and the preferred standard is
  ASCII (American Standard Code for Information Interchange).
  For example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.

  A modern encryption method is to take a text file, convert the bytes to ASCII, then XOR
  each byte with a given value, taken from a secret key.
  The advantage with the XOR function is that using the same encryption key on the cipher text,
  restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.

  For unbreakable encryption, the key is the same length as the plain text message, and the
  key is made up of random bytes.
  The user would keep the encrypted message and the encryption key in different locations,
  and without both "halves", it is impossible to decrypt the message.

  Unfortunately, this method is impractical for most users, so the modified method is
  to use a password as a key.
  If the password is shorter than the message, which is likely, the key is repeated cyclically
  throughout the message.
  The balance for this method is using a sufficiently long password key for security, but short enough to be memorable.

  Your task has been made easy, as the encryption key consists of three lower case characters.
  Using p059_cipher.txt (right click and 'Save Link/Target As...'), a file containing the
  encrypted ASCII codes, and the knowledge that the plain text must contain common English words,
  decrypt the message and find the sum of the ASCII values in the original text.

  """

  @doc """
  The purpose of the `main` function is to measure the execution time of a function.
  """
  def main() do
    time_start = Time.utc_now    # start chrono

    result = solve()

    time_finish = Time.utc_now   # stop chrono
    time_delta = Time.diff(time_finish, time_start, :microsecond)
    delta_sec = div(time_delta, 1_000_000)
    delta_msec = div(time_delta, 1_000)
    delta_micsec = rem(time_delta, 1_000)

    IO.puts "Result         : #{IO.inspect result}"
    IO.puts "Execution time : #{delta_sec} s,  #{delta_msec} ms #{delta_micsec} micros"
  end

  @doc """
  """
  def solve() do
    {:ok, text}  = File.read("data/p059_cipher.txt") 
    chars = 
      text 
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    
    {_ , ascii_sum, _} =
      for i <- ?a..?z, j <- ?a..?z, k <- ?a..?z do
        decoded = 
          chars
          |> xor_charlist([i,j,k])
          |> List.to_string
        if String.printable?(decoded) && ( decoded |> String.contains?("Euler")) do
          IO.inspect {[i,j,k],decoded |> String.to_charlist |> Enum.sum, decoded |> String.split_at(64) |> elem(0) }
          {[i,j,k],decoded |> String.to_charlist |> Enum.sum, decoded |> String.split_at(64) |> elem(0) }
        end
      end
      |> Enum.filter(&(&1))
      |> List.first
    ascii_sum
  end
  def xor_charlist(char_data,key) do
    len = Enum.count(char_data)
    long_key = Stream.cycle(key) |> Enum.take(len)

    for {value,key} <- Enum.zip(char_data,long_key) do
      Bitwise.bxor(value,key) 
    end
  end
end
