defmodule Day6 do

    defp hold_button(time_left, curr_speed, min_dist, n_wins) do        
        if time_left == 0 do
            if max_dist(time_left, curr_speed) > min_dist do
                n_wins + 1
            end
            n_wins
        else
            if max_dist(time_left, curr_speed) > min_dist do                
                hold_button(time_left - 1, curr_speed + 1, min_dist, n_wins + 1)
            else
                hold_button(time_left - 1, curr_speed + 1, min_dist, n_wins)
            end
        end
    end

    defp max_dist(time_left, curr_speed) do
        time_left * curr_speed
    end

    def solution_1() do
        {:ok, contents} = File.read("input-6.txt")
        time = [7, 15, 30]
        distance = [9, 40, 200]
        max_time = Enum.max(time)
        max_distance = Enum.max(distance)
        total = hold_button(60, 0, 475, 0) * hold_button(94, 0, 2138, 0) * hold_button(78, 0, 1015, 0) * hold_button(82, 0, 1650, 0)

        IO.inspect total
    end

    def solution_2() do
        {:ok, contents} = File.read("input-6.txt")
        time = [7, 15, 30]
        distance = [9, 40, 200]
        max_time = Enum.max(time)
        max_distance = Enum.max(distance)
        total = hold_button(60947882, 0, 475213810151650, 0)

        IO.inspect total
    end

end

Day6.solution_1()
Day6.solution_2()
