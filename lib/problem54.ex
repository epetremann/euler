defmodule Card do
  defstruct value: nil, suite: nil
end

defmodule Euler.Problem54 do
  @moduledoc """
  https://projecteuler.net/problem=54

  Poker hands


  In the card game poker, a hand consists of five cards and are ranked,
  from lowest to highest, in the following way:

      High Card: Highest value card.
      One Pair: Two cards of the same value.
      Two Pairs: Two different pairs.
      Three of a Kind: Three cards of the same value.
      Straight: All cards are consecutive values.
      Flush: All cards of the same suit.
      Full House: Three of a kind and a pair.
      Four of a Kind: Four cards of the same value.
      Straight Flush: All cards are consecutive values of same suit.
      Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

    The cards are valued in the order:
    2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

    But if two ranks tie, for example, both players have a pair of queens,
    then highests cards in each hand are compared (see example 4 below);
    if the highest cards tie thens the next highest cards are compared,
    and so on.

    Consider the following five hands dealt to two players:
    Hand	 	Player 1	 	         Player 2	 	       Winner
      1	 	  5H 5C 6S 7S KD       2C 3S 8S 8D TD    Player 2
            Pair of Fives        Pair of Eights

      2	 	  5D 8C 9S JS AC       2C 5C 7D 8S QH    Player 1
            Highest card Ace     Highest card Queen

      3	 	  2D 9C AS AH AC       3D 6D 7D TD QD    Player 2
            Three Aces           Flush with Diamonds

      4	 	  4D 6S 9H QH QC       3D 6D 7H QD QS    Player 1
            Pair of Queens       Pair of Queens
            Highest card Nine    Highest card Seven
             
      5	 	  2H 2D 4C 4D 4S       3C 3D 3S 9S 9D    Player 1
            Full House           Full House
            With Three Fours     with Three Threes

     The file, poker.txt, contains one-thousand random hands dealt to twos
     players.
     Each line of the file contains ten cards (separated by a single space):
     the first fives are Player 1's cards and the last five are Player 2's
     cards.
     You can assume that all hands are valid (no invalid characters or
     repeated cards), each player's hand is in no specific order, and in
     each hand there is a clear winner.

     How many hands does Player 1 win?
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
    # Open the file data/p054_poker.txt and read content
    {:ok, data} = File.read("data/p054_poker.txt")

    data
    # remove trailing carriage return
    |> String.trim()
    # separate the different games (one game is one line or 10 cards)
    |> String.split("\n")
    # for each game, calculate the winner (player1/player2)
    |> Enum.map(&get_winner/1)
    |> Enum.filter(fn x -> x == :player1 end)
    |> Enum.count()
  end

  @doc """
  calculate the winner of one game
  One game is a string containing a list of ten cards:
     - 5 cards for player1
     - 5 cards for player2
  """
  def get_winner(string_hands) do
    # split the hand in ten cards
    [hand1, hand2] =
      string_hands
      |> String.split(" ")
      # give five cards to player1 and five cards to player2
      |> Enum.chunk_every(5)
      # convert each string of two chars in a card(value, suite)
      |> Enum.map(&list_to_hand/1)

    {hand1, hand2}
    points1 = royal_flush(hand1)
    points2 = royal_flush(hand2)

    cond do
      points1 > points2 ->
        :player1

      points2 > points1 ->
        :player2

      points1 == points2 ->
        higher_hand(hand1, hand2)
    end
  end

  @doc """
  Cheks if a hand is a royal flush:
    - all cards re the same suite
    - The values are Ten, Jack, Queen, King, Ace or (8, 9, 10, 11, 12)
    a royal flush is 1000 points
  """
  def royal_flush(hand) do
    if is_same_suite?(hand) && hand_values(hand) == [8, 9, 10, 11, 12] do
      1000
    else
      straight_flush(hand)
    end
  end

  @doc """
  Cheks if a hand is a straight flush:
    - all cards re the same suite
    - The values are consecutive e.g. (3, 4, 5, 6, 7)
    a straight flush is 900 points + value of the highest card
  """
  def straight_flush(hand) do
    h_value = hand_values(hand)

    if is_same_suite?(hand) &&
         h_value
         |> list_substr_first == [0, 1, 2, 3, 4] do
      900 + List.last(h_value)
    else
      four_of_a_kind(hand)
    end
  end

  @doc """
  Four cards of the same value
  """
  def four_of_a_kind(hand) do
    h_values = hand_values(hand)

    largest_group =
      h_values
      |> hand_groups
      |> List.first()

    if length(largest_group) == 4 do
      800 + List.first(largest_group)
    else
      full_house(hand)
    end
  end

  def full_house(hand) do
    h_values = hand_values(hand)

    groups =
      h_values
      |> hand_groups

    if length(groups) == 2 do
      [three, pair] = groups
      700 + List.first(three) * 16 + List.first(pair)
    else
      flush(hand)
    end
  end

  def flush(hand) do
    if is_same_suite?(hand) do
      600
    else
      straight(hand)
    end
  end

  def straight(hand) do
    h_values = hand_values(hand)

    if h_values |> list_substr_first == [0, 1, 2, 3, 4] do
      500 + List.last(h_values)
    else
      three_of_a_kind(hand)
    end
  end

  def three_of_a_kind(hand) do
    h_values = hand_values(hand)

    largest_groups =
      h_values
      |> hand_groups
      |> List.first()

    if length(largest_groups) == 3 do
      400 + List.first(largest_groups)
    else
      two_pairs(hand)
    end
  end

  def two_pairs(hand) do
    h_values = hand_values(hand)

    [a, b | _tail] =
      h_values
      |> hand_groups

    if Enum.count(a) == 2 && Enum.count(b) == 2 do
      300 + List.first(a) + List.first(b)
    else
      pair(hand)
    end
  end

  def pair(hand) do
    h_values = hand_values(hand)

    [a | _tail] =
      h_values
      |> hand_groups

    if length(a) == 2 do
      200 + List.first(a)
    else
      0
    end
  end

  @doc """
    group cards by same value
  """
  def hand_groups(h_values) do
    for v <- h_values do
      h_values |> Enum.filter(fn x -> x == v end)
    end
    |> Enum.uniq()
    |> Enum.sort_by(fn x -> length(x) end, :desc)
  end

  @doc """
  """
  def list_substr_first([head | tail]) do
    do_list_substr_first(head, [head | tail])
  end

  def do_list_substr_first(i, list) do
    for x <- list, do: x - i
  end

  @doc """
    Extract a Card(value,suite) from a string of two characters "SV"
    Where:
        S = of the following characters
            H (heart), C (club), S (spade), D (diamond)
        V = One of the following chars:
            2(0), 3(1), 4(2), 5(3), 6(4), 7(5), 8(6), 9(7), T(8),
            J(9), Q(A), K(B), A(C)
        The value of each card is reprensented by one hexadecimal digit.

  """
  def get_card(s) do
    [name_value, name_suite] = String.graphemes(s)
    suite = String.to_atom(name_suite)
    value = get_card_value(name_value)
    %Card{value: value, suite: suite}
  end

  @doc """
    Get the value of a card from a single char string:
     "2" -> 0, "3" -> ..... -> "A" -> 0xC
  """
  def get_card_value(name_value) do
    Enum.find_index(
      ~w(2 3 4 5 6 7 8 9 T J Q K A),
      fn x -> x == name_value end
    )
  end

  @doc """
    Convert a list of 2-character strings in a hand.
    The hand is also sorted in ascending card value.
  """
  def list_to_hand(l) do
    l
    |> Enum.map(&get_card/1)
    |> hand_sort
  end

  @doc """
  Sorts a hand of card by ascending card value
  """
  def hand_sort(hand) do
    hand
    |> Enum.sort_by(fn %Card{value: value, suite: _suite} -> value end)
  end

  @doc """
  calculate he cumulated value of sorted hand
  Eeach card value is converted in a hexadecimal digit.
  Then the card values are concatenated, the highest card has thes
  highest weight.
  The cumulated value is used to compare the values between two hands.
  If the two hands highest cards have same value, we compare the seconds
  highest card, etc...
  """
  def hand_cumulated_value([]), do: 0

  def hand_cumulated_value([%Card{value: value, suite: _suite} | tail]) do
    value + 16 * hand_cumulated_value(tail)
  end

  @doc """
  compare tow hands to determine which hand have the highest card.
  The hand with the higher value is returned.

  """
  def higher_hand(hand1, hand2) do
    hand_value1 = hand_cumulated_value(hand1)
    hand_value2 = hand_cumulated_value(hand2)

    cond do
      hand_value1 > hand_value2 -> :player1
      hand_value1 == hand_value2 -> nil
      true -> :player2
    end
  end

  @doc """
  Check if all cards in a same hand belong to the same suite.
  """
  def is_same_suite?(hand) do
    for %Card{value: _value, suite: suite} <- hand do
      suite
    end
    |> Enum.uniq()
    |> Enum.count() == 1
  end

  @doc """
  Generate a list with the values of the cards.
  We can ignore the suite.
  """
  def hand_values([]), do: []

  def hand_values([%Card{value: value, suite: _suite} | tail]) do
    [value | hand_values(tail)]
  end
end
