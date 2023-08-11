defmodule Main do
  def main do
    read_integer_array()
    |> solve
    |> IO.puts
  end

  def solve n do
    
  end
  
  # 文字列読み込み
  # in: 
  # rikka
  # out:
  # "rikka"
  def read_string do
    IO.read(:line)
    |> String.trim
  end    

  # 整数読み込み
  # in:
  # 155
  # out:
  # 155 (int)
  def read_integer do
    read_string()
    |> String.to_integer
  end

  # 文字列複数行読み込み
  # in:
  # rikka
  # akane
  # namiko
  # out:
  # ["rikka", "akane", "namiko"]
  def read_string_lines do
    IO.read(:all)
    |> String.split("\n", trim: true)
  end

  # 整数複数行読み込み
  # in:
  # 155
  # 149
  # 150
  # out:
  # [155, 149, 150]
  def read_integer_lines do
    read_string_lines()
    |> Enum.map(&String.to_integer/1)
  end

  # 文字列配列読み込み
  # in:
  # rikka akane namiko
  # out:
  # ["rikka", "akane", "namiko"]
  def read_string_array do
    read_string()
    |> String.split(" ", trim: true)
  end

  # 整数配列読み込み
  # in:
  # 155 149 150
  # out:
  # [155, 149, 150]
  def read_integer_array do
    read_string_array()
    |> Enum.map(&String.to_integer/1)
  end
    
  # 文字列タプル読み込み
  # in:
  # rikka akane namiko
  # out:
  # {"rikka", "akane", "namiko"}
  def read_string_tuple do
    read_string_array()
    |> List.to_tuple()
  end

  # 整数タプル読み込み
  # in:
  # 155 149 150
  # out:
  # {155, 149, 150}
  def read_integer_tuple do
    read_integer_array()
    |> List.to_tuple()
  end

  # 2次元文字列配列読み込み
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out:
  # [["rikka", "akane", "namiko"], ["yume", "chise", "mujina"]]
  def read_multi_string_array do
    read_string_lines()
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
    end)
  end

  # 2次元整数配列読み込み
  # in:
  # 155 149 150
  # 160 144 175
  # out:
  # [[155, 149, 150], [160, 144, 175]]
  def read_multi_integer_array do
    read_multi_string_array()
    |> Enum.map(fn line ->
      line
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # 個数指定2次元文字列配列読み込み
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out: (n=1)
  # [["rikka", "akane", "namiko"]]
  def read_multi_string_array n do
    for _ <- 1..n ,reduce: [] do
      acc -> [read_string_array() | acc]
    end
    |> Enum.reverse()
  end

  # 個数指定2次元整数配列読み込み
  # in:
  # 155 149 150
  # 160 144 175
  # out: (n=1)
  # [[155, 149, 150]]
  def read_multi_integer_array n do
    read_multi_string_array(n)
    |> Enum.map(fn line ->
      line
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # 2次元配列を2次元タプルに変換
  defp two_d_array_to_tuple n do
    n
    |> Enum.map(fn line ->
      line
      |> List.to_tuple()
    end)
    |> List.to_tuple()
  end

  # 2次元文字列タプル読み込み
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out:
  # {{"rikka", "akane", "namiko"}, {"yume", "chise", "mujina"}}
  def read_multi_string_tuple do
    read_multi_string_array()
    |> two_d_array_to_tuple
  end

  # 2次元整数タプル読み込み
  # in:
  # 155 149 150
  # 160 144 175
  # out:
  # {{155, 149, 150}, {160, 144, 175}}
  def read_multi_integer_tuple do
    read_multi_integer_array()
    |> two_d_array_to_tuple
  end

  # 個数指定2次元文字列タプル読み込み
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out: (n=1)
  # {{"rikka", "akane", "namiko"}}
  def read_multi_string_tuple n do
    read_multi_string_array(n)
    |> two_d_array_to_tuple
  end
  
  # 個数指定2次元整数タプル読み込み
  # in:
  # 155 149 150
  # 160 144 175
  # out: (n=1)
  # {{155, 149, 150}}
  def read_multi_integer_tuple n do
    read_multi_integer_array(n)
    |> two_d_array_to_tuple
  end
end
