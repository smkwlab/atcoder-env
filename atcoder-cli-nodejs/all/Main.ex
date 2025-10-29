defmodule Main do
  import Bitwise

  def main do
    n = read_integer()
    m = read_integer()

    s = read_string()

    ia = read_integer_array()
    sa = read_string_array()

    read_multi_integer_array()
#    |> read_multi_string_array()
#    |> read_integer_array()
#    |> read_string_array()
    |> solve()
    |> IO.puts
  end

  def solve(n) do

  end


  #
  # helper 関数群
  #

  # 文字列1行読み込み
  @spec read_string() :: String.t
  # in:
  # rikka
  # out:
  # "rikka"
  def read_string do
    :line
    |> IO.read()
    |> String.trim
  end

  # 整数1行読み込み
  @spec read_integer() :: integer
  # in:
  # 155
  # out:
  # 155 (int)
  def read_integer do
    read_string()
    |> String.to_integer()
  end

  # 文字列配列1行読み込み
  @spec read_string_array() :: [String.t]
  # in:
  # rikka akane namiko
  # out:
  # ["rikka", "akane", "namiko"]
  def read_string_array do
    read_string()
    |> String.split(" ", trim: true)
  end

  # 整数配列1行読み込み
  @spec read_integer_array() :: [integer]
  # in:
  # 155 149 150
  # out:
  # [155, 149, 150]
  def read_integer_array do
    read_string()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  # 文字列全行読み込み
  @spec read_string_lines() :: [String.t]
  # in:
  # rikka
  # akane
  # namiko
  # out:
  # ["rikka", "akane", "namiko"]
  def read_string_lines do
    :eof
    |> IO.read()
    |> String.split("\n", trim: true)
  end

  # 整数全行読み込み
  @spec read_integer_lines() :: [integer]
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

  # 2次元文字列配列全行読み込み
  @spec read_multi_string_array() :: [[String.t]]
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out:
  # [["rikka", "akane", "namiko"], ["yume", "chise", "mujina"]]
  def read_multi_string_array do
    read_string_lines()
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  # 2次元整数配列全行読み込み
  @spec read_multi_integer_array() :: [[integer]]
  # in:
  # 155 149 150
  # 160 144 175
  # out:
  # [[155, 149, 150], [160, 144, 175]]
  def read_multi_integer_array do
    read_string_lines()
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # 行数指定文字列複数行読み込み
  @spec read_string_lines(integer) :: [String.t]
  # in:
  # rikka
  # akane
  # namiko
  # out:
  # ["rikka", "akane", "namiko"]
  def read_string_lines(n) do
    read_string_lines(n, [])
  end

  def read_string_lines(0, acc), do: Enum.reverse(acc)
  def read_string_lines(n, acc) do
    read_string_lines(n - 1, [read_string() | acc])
  end

  # 行数指定整数複数行読み込み
  @spec read_integer_lines(integer) :: [integer]
  # in:
  # 155
  # 149
  # 150
  # out:　（n=3）
  # [155, 149, 150]
  def read_integer_lines(n) do
    read_string_lines(n)
    |> Enum.map(&String.to_integer/1)
  end

  # 行数指定2次元文字列配列読み込み
  @spec read_multi_string_array(integer) :: [[String.t]]
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out: (n=1)
  # [["rikka", "akane", "namiko"]]
  def read_multi_string_array(n) do
    read_string_lines(n)
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  # 行数指定2次元整数配列読み込み
  @spec read_multi_integer_array(integer) :: [[integer]]
  # in:
  # 155 149 150
  # 160 144 175
  # out: (n=2)
  # [[155, 149, 150], [160, 144, 175]]
  def read_multi_integer_array(n) do
    read_string_lines(n)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
