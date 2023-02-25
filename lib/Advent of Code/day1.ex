defmodule Day1 do
  def func do
    #body = File.read!("lib/Advent of Code/day1.txt")
    File.read!("lib/Advent of Code/day1.txt")
          |> String.split("\n\n") |> Enum.map(fn x -> String.split(x, "\n") end)
            |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
              |> Enum.map(fn x -> Enum.sum(x) end)
                |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum#|> List.first()


    # list = String.split(body, "\n\n")
    # list = Enum.map(list, fn x -> String.split(x, "\n") end)
    # IO.inspect(list)
    # list = Enum.map(list, fn x -> Enum.map(x, &String.to_integer/1) end)
    # list = Enum.map(list, fn x -> Enum.sum(x) end)
    # list = Enum.sort(list, :desc)

    # List.first(list)
    #"lib/Advent of Code/day1.txt"
  end
end
