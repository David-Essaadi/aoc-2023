defmodule Day2 do

    def max_of_color(str, color) do
        Regex.scan(~r/(\d+) #{color}/, str)
        |> Enum.flat_map(&tl/1)
        |> Enum.map(&String.to_integer/1)
        |> Enum.max()
    end

    def check_color(str, color, max_n) do
        max_of_color(str, color) > max_n
    end

    def solution_1(max_red, max_green, max_blue) do
        {:ok, contents} = File.read("input-2.txt")

        sum =
            String.trim(contents)
            |> String.split("\n")
            |> Enum.map(fn str -> check_color(str, "red", max_red) || check_color(str, "green", max_green) || check_color(str, "blue", max_blue) end)
            |> Enum.with_index(1)
            |> Enum.filter(fn {b, _} -> !b end)
            |> Enum.map(fn {_, v} -> v end)
            |> Enum.sum()
        IO.inspect sum
    end

    def solution_2() do
        {:ok, contents} = File.read("input-2.txt")

        sum =
            String.trim(contents)
            |> String.split("\n")
            |> Enum.map(fn str -> max_of_color(str, "red") * max_of_color(str, "green") * max_of_color(str, "blue") end)
            |> Enum.sum()
        IO.inspect sum
    end

end

Day2.solution_1(12, 13, 14)
Day2.solution_2()
