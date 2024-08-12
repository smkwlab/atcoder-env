defmodule Main do
  import Bitwise

  def main do
    input = read_all()

    {n, input} = read_integer(input)
    {m, input} = read_integer(input)

    {s, input} = read_string(input)

    {ia, input} = read_integer_array(input)
    {sa, input} = read_string_array(input)

#    read_all()
#    |> read_line_drop()
    input
    |> read_multi_integer_array()
#    |> read_multi_string_array()
    |> solve()
    |> IO.puts
  end

  def solve(n) do

  end

  # 全行読み込み // この関数の返り値をこれ以降の関数に渡す
  @spec read_all() :: [String.t]
  def read_all do
    "/dev/stdin"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  # 一行読み捨て
  @spec read_line_drop([String.t]) :: [String.t]
  def read_line_drop([_ | input]), do: input

  # 文字列読み込み
  # in:
  # rikka
  # out:
  # "rikka"
  @spec read_string([String.t]) :: String.t | {String.t, [String.t]}
  def read_string([result | []]), do: result
  def read_string([result | input]), do: {result, input}

  # 整数読み込み
  # in:
  # 155
  # out:
  # 155 (int)
  @spec read_integer([String.t]) :: integer | {integer, [String.t]}
  def read_integer([result | []]), do: read_integer_once(result)
  def read_integer([result | input]), do: {read_integer_once(result), input}
  defp read_integer_once(str), do: String.to_integer(str)

  # 文字列配列読み込み
  # in:
  # rikka akane namiko
  # out:
  # ["rikka", "akane", "namiko"]
  @spec read_string_array([String.t]) :: [String.t] | {[String.t], [String.t]}
  def read_string_array([result | []]), do: read_string_array_once(result)
  def read_string_array([result | input]) do
    {
      read_string_array_once(result),
      input
    }
  end
  defp read_string_array_once(result), do: String.split(result, " ", trim: true)

  # 整数配列読み込み
  # in:
  # 155 149 150
  # out:
  # [155, 149, 150]
  @spec read_integer_array([String.t]) :: [integer] | {[integer], [String.t]}
  def read_integer_array([result | []]), do: read_integer_array_once(result)
  def read_integer_array([result | input]) do
    {
      read_integer_array_once(result),
      input
    }
  end
  defp read_integer_array_once(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  # 文字列複数行読み込み
  # in:
  # rikka
  # akane
  # namiko
  # out:
  # ["rikka", "akane", "namiko"]
  @spec read_string_lines([String.t]) :: [String.t]
  def read_string_lines(input), do: input

  # 整数複数行読み込み
  # in:
  # 155
  # 149
  # 150
  # out:
  # [155, 149, 150]
  @spec read_integer_lines([String.t]) :: [integer]
  def read_integer_lines(input) do
    Enum.map(input, &String.to_integer/1)
  end

  # 2次元文字列配列読み込み
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out:
  # [["rikka", "akane", "namiko"], ["yume", "chise", "mujina"]]
  @spec read_multi_string_array([String.t]) :: [[String.t]]
  def read_multi_string_array(input) do
    Enum.map(input, &String.split(&1, " ", trim: true))
  end

  # 2次元整数配列読み込み
  # in:
  # 155 149 150
  # 160 144 175
  # out:
  # [[155, 149, 150], [160, 144, 175]]
  @spec read_multi_integer_array([String.t]) :: [[integer]]
  def read_multi_integer_array(input) do
    input
    |> read_multi_string_array()
    |> Enum.map(fn line ->
      line
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # 行数指定文字列複数行読み込み
  @spec read_string_lines(integer, [String.t]) :: {[String.t], [String.t]}
  def read_string_lines(n, input) do
    read_string_lines_sub(n, input, [])
  end
  defp read_string_lines_sub(0, input, acc), do: {Enum.reverse(acc), input}
  defp read_string_lines_sub(n, [result | input], acc) do
    read_string_lines_sub(n-1, input, [result | acc])
  end

  # 行数指定整数複数行読み込み
  @spec read_integer_lines(integer, [String.t]) :: {[integer], [String.t]}
  def read_integer_lines(n, input) do
    {lines, input} = read_string_lines(n, input)

    {read_integer_lines(lines), input}
  end

  # 個数指定2次元文字列配列読み込み
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out: (n=1)
  # [["rikka", "akane", "namiko"]]
  # from https://atcoder.jp/contests/abs/submissions/48189543
  @spec read_multi_string_array(integer, [String.t]) :: {[[String.t]], [String.t]}
  def read_multi_string_array(n, input) do
    {lines, input} = read_string_lines(n, input)

    {read_multi_string_array(lines), input}
  end

  # 個数指定2次元整数配列読み込み
  # in:
  # 155 149 150
  # 160 144 175
  # out: (n=2)
  # [[155, 149, 150], [160, 144, 175]]
  # from https://atcoder.jp/contests/abs/submissions/48189543
  @spec read_multi_integer_array(integer, [String.t]) :: {[[integer]], [String.t]}
  def read_multi_integer_array(n, input) do
    {lines, input} = read_string_lines(n, input)

    {read_multi_integer_array(lines), input}
  end
end
