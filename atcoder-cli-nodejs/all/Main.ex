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
  defmacro get_input do
    quote do
      case Process.get(:input) do
        nil ->
          __input_lines__ =
            "/dev/stdin"
            |> File.read!()
            |> String.split("\n", trim: true)
          Process.put(:input, __input_lines__)
          __input_lines__
        __existing_lines__ ->
          __existing_lines__
      end
    end
  end

  defmacro update_input(new_input) do
    quote do: Process.put(:input, unquote(new_input))
  end

  # 文字列1行読み込み
  # in:
  # rikka
  # out:
  # "rikka"
  defmacro read_string do
    quote do
      [__result__ | __rest__] = get_input()
      Process.put(:input, __rest__)
      __result__
    end
  end

  # 整数1行読み込み
  @spec read_integer() :: integer
  # in:
  # 155
  # out:
  # 155 (int)
  def read_integer, do: String.to_integer(read_string())

  # 文字列配列1行読み込み
  @spec read_string_array() :: [String.t]
  # in:
  # rikka akane namiko
  # out:
  # ["rikka", "akane", "namiko"]
  def read_string_array, do: String.split(read_string(), " ", trim: true)

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
  # in:
  # rikka
  # akane
  # namiko
  # out:
  # ["rikka", "akane", "namiko"]
  defmacro read_string_lines do
    quote do
      __all_input__ = get_input()
      update_input([])
      __all_input__
    end
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
    Enum.map(read_string_lines(), &String.to_integer/1)
  end

  # 2次元文字列配列全行読み込み
  @spec read_multi_string_array() :: [[String.t]]
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out:
  # [["rikka", "akane", "namiko"], ["yume", "chise", "mujina"]]
  def read_multi_string_array do
    Enum.map(read_string_lines(), &String.split(&1, " ", trim: true))
  end

  # 2次元整数配列全行読み込み
  @spec read_multi_integer_array() :: [[integer]]
  # in:
  # 155 149 150
  # 160 144 175
  # out:
  # [[155, 149, 150], [160, 144, 175]]
  def read_multi_integer_array do
    Enum.map(read_string_lines(), fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # 行数指定文字列複数行読み込み
  # in:
  # rikka
  # akane
  # namiko
  # out:
  # ["rikka", "akane", "namiko"]
  defmacro read_string_lines(n) do
    quote do
      {__result__, __rest__} = Enum.split(get_input(), unquote(n))
      update_input(__rest__)
      __result__
    end
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
    Enum.map(read_string_lines(n), &String.to_integer/1)
  end

  # 行数指定2次元文字列配列読み込み
  @spec read_multi_string_array(integer) :: [[String.t]]
  # in:
  # rikka akane namiko
  # yume chise mujina
  # out: (n=1)
  # [["rikka", "akane", "namiko"]]
  def read_multi_string_array(n) do
    Enum.map(read_string_lines(n), &String.split(&1, " ", trim: true))
  end

  # 行数指定2次元整数配列読み込み
  @spec read_multi_integer_array(integer) :: [[integer]]
  # in:
  # 155 149 150
  # 160 144 175
  # out: (n=2)
  # [[155, 149, 150], [160, 144, 175]]
  def read_multi_integer_array(n) do
    Enum.map(read_string_lines(n), fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
