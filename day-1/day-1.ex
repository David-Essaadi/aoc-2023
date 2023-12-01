defmodule Day1 do

    def only_digits(str) do
        String.replace str, ~r/[^\d]/, ""
    end

    def str_to_digits(str) do
        String.replace(str, "zero", "z0o")
        |> String.replace("one", "o1e")
        |> String.replace("two", "t2o")
        |> String.replace("three", "t3e")
        |> String.replace("four", "f4r")
        |> String.replace("five", "f5e")
        |> String.replace("six", "s6x")
        |> String.replace("seven", "s7n")
        |> String.replace("eight", "e8t")
        |> String.replace("nine", "n9e")
    end

    def first_and_last(str) do
        String.first(str) <> String.last(str)
    end

    def solution_1 do
        {:ok, contents} = File.read("input-1.txt")

        sum = 
            String.trim(contents)
            |> String.split("\n")
            |> Enum.map(&only_digits/1)
            |> Enum.map(&first_and_last/1)
            |> Enum.map(&String.to_integer/1)
            |> Enum.sum()
        IO.puts sum
    end

    def solution_2() do
        {:ok, contents} = File.read("input-1.txt")

        sum = 
            String.trim(contents)
            |> String.split("\n")
            |> Enum.map(&str_to_digits/1)
            |> Enum.map(&only_digits/1)
            |> Enum.map(&first_and_last/1)
            |> Enum.map(&String.to_integer/1)
            |> Enum.sum()
        IO.puts sum
    end
    
end

Day1.solution_1()
Day1.solution_2()