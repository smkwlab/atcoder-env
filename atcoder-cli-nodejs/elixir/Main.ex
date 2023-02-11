defmodule Main do
  def main do
    read_single_array()
    |> solve
    |> IO.puts
  end

  def solve n do
    
  end

  def read_string do
    IO.gets("")
    |> String.trim
  end    

  def read_integer do
    read_string()
    |> String.to_integer
  end

  def read_single_array do
    read_string()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
    
  def read_single_tuple do
    read_single_array()
    |> List.to_tuple()
  end

  def read_multi_array do
    IO.read(:all)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def read_multi_array n do
    for _ <- 1..n ,reduce: [] do
      acc -> [read_single_array() | acc]
    end
    |> Enum.reverse()
  end

  def read_multi_tuple do
    IO.read(:all)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> List.to_tuple()
  end

  def read_multi_tuple n do
    for _ <- 1..n ,reduce: [] do
      acc -> [read_single_tuple() | acc]
    end
    |> Enum.reverse()
    |> List.to_tuple()
  end
end
