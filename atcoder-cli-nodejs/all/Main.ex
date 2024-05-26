defmodule Main do
  def main do
    n = read_integer()

    read_integer_array()
    |> solve()
    |> IO.puts
  end

  def solve(n) do

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

  # 行数指定文字列複数行読み込み
  def read_string_lines(n), do: read_string_lines_sub(n, [])
  defp read_string_lines_sub(0, acc), do: Enum.reverse(acc)
  defp read_string_lines_sub(n, acc), do: read_string_lines_sub(n-1, [read_string() | acc])

  # 行数指定整数複数行読み込み
  def read_integer_lines n do
    read_string_lines(n)
    |> Enum.map(&String.to_integer/1)
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

  # 個数指定2次元文字列配列読み込み
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out: (n=1)
  # [["rikka", "akane", "namiko"]]
  # from https://atcoder.jp/contests/abs/submissions/48189543
  def read_multi_string_array(n) do
    IO.stream(:stdio, 65536)
    |> Stream.transform({[], "", n}, &st_s/2)
    |> Enum.to_list()
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

  # 個数指定2次元整数配列読み込み
  # in:
  # 155 149 150
  # 160 144 175
  # out: (n=2)
  # [[155, 149, 150], [160, 144, 175]]
  # from https://atcoder.jp/contests/abs/submissions/48189543
  def read_multi_integer_array(n) do
    IO.stream(:stdio, 65536)
    |> Stream.transform({[], "", n}, &st_i/2)
    |> Enum.to_list()
  end

  defp st_s(h, l), do: st(h, l, &st_s_sub)
  defp st_s_sub(l, c) do
    Enum.take(l, c)
    |> Enum.map(&String.split(&1, " "))
  end

  defp st_i(h, l), do: st(h, l, &st_i_sub)
  defp st_i_sub(l, c) do
    st_s_sub(l, c)
    |> Enum.map(fn l -> Enum.map(l, &String.to_integer/1) end)
  end
  
  defp st(_h, {l1, l2, 0}, _fun), do: {:halt, {l1, l2, 0}}
  defp st(h, {l1, l2, n}, fun) when n > 0 do
    h = Enum.join(l1 ++ ["#{l2}#{h}"], " ")

    if String.match?(h, ~r/\n/) do
      l = String.split(h, "\n")
      c = Enum.count(l)

      last =
        Enum.take(l, -1)
        |> hd()

      l = fun.(l, c-1)

      n = n - (c - 1)

      if String.match?(last, ~r/ /) do
        l1 = String.split(last, " ")
        c = Enum.count(l1)
        l2 = (Enum.take(l1, -1) |> hd())
        l1 = Enum.take(l1, c - 1)
        {l, {l1, l2, n}}
      else
        {l, {[], last, n}}
      end
    else
      {[], {l1, h, n}}
    end
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


  # 2次元配列を2次元タプルに変換
  defp two_d_array_to_tuple(n) do
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
  def read_multi_string_tuple(n) do
    read_multi_string_array(n)
    |> two_d_array_to_tuple
  end

  # 個数指定2次元整数タプル読み込み
  # in:
  # 155 149 150
  # 160 144 175
  # out: (n=1)
  # {{155, 149, 150}}
  def read_multi_integer_tuple(n) do
    read_multi_integer_array(n)
    |> two_d_array_to_tuple
  end
end
