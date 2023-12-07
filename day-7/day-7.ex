defmodule Day7 do
  def card_strength(card) do
    case card do
        "A" -> 14
        "K" -> 13
        "Q" -> 12
        "J" -> 11
        "T" -> 10
        strength -> String.to_integer(strength)
    end
  end

  def card_strength_jokers(card) do
    case card do
        "A" -> 14
        "K" -> 13
        "Q" -> 12
        "J" -> 1
        "T" -> 10
        strength -> String.to_integer(strength)
    end
  end

  def preprocess_jokers({hand, bet} = _args) do
    freq = Enum.frequencies hand |> Enum.filter(fn x -> x != "J" end)
    {most_freq, _} = case freq do
        x when x == %{} -> {"J", 1}
        _ -> Enum.max_by(freq, fn {_, i} -> i end)
    end
    sorted_by_char = hand |> Enum.map(fn x -> String.replace(x, "J", most_freq) end) |> Enum.sort 
    sorted_by_freq = Enum.sort_by sorted_by_char, fn x -> freq[x] end,  :desc
    {hand, sorted_by_freq, bet}
  end

  def preprocess({hand, bet} = _args) do
    freq = Enum.frequencies hand
    sorted_by_char = Enum.sort hand
    sorted_by_freq = Enum.sort_by sorted_by_char, fn x -> freq[x] end,  :desc
    {hand, sorted_by_freq, bet}
  end

  def type({hand, sorted, bet} = _args) do
    outcome = case sorted do
      [a, a, a, a, a] -> {:five_of_a_kind, 7}
      [a, a, a, a, _] -> {:four_of_a_kind, 6}
      [a, a, a, b, b] -> {:full_house, 5}
      [a, a, a, _, _] -> {:three_of_a_kind, 4}
      [a, a, b, b, _] -> {:two_pair, 3}
      [a, a, _, _, _] -> {:one_pair, 2}
      _ -> {:high_card, 1}
    end
    {_, worth} = outcome
    {worth, hand, bet}
  end

  def rank(hands, rank_fn) do
    hands
    |> Enum.map(&type/1)
    |> Enum.map(fn {worth, hand, bet} -> {worth, Enum.map(hand, rank_fn), bet} end)
    |> Enum.sort
  end

  def solution_1() do
    {:ok, contents} = File.read("input.txt")
    hands = contents
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn line -> [a, b] = String.split(line, " "); {a, b} end)
            
    result = hands
    |> Enum.map(fn {hand, bet} = _ -> {String.split(hand, "", trim: true), String.to_integer bet} end) 
    |> Enum.map(&preprocess/1)
    |> rank(&card_strength/1)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, _, bet}, idx} = _ -> bet * idx end)
    |> Enum.sum

    IO.inspect result
  end

  def solution_2() do
    {:ok, contents} = File.read("input.txt")
    hands = contents
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn line -> [a, b] = String.split(line, " "); {a, b} end)
            
    result = hands
    |> Enum.map(fn {hand, bet} = _ -> {String.split(hand, "", trim: true), String.to_integer bet} end) 
    |> Enum.map(&preprocess_jokers/1)
    |> rank(&card_strength_jokers/1)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, _, bet}, idx} = _ -> bet * idx end)
    |> Enum.sum

    IO.inspect result
  end
end

Day7.solution_1()
Day7.solution_2()