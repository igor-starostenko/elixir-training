defmodule Sequential do
  # 2.1 A
  def sum(n) when n > 1 do
    n + sum(n - 1)
  end
  def sum(1), do: 1

  # 2.1 A
  def sum_interval(n, m) when n < m do
    n + sum_interval(n + 1, m)
  end
  def sum_interval(n, m) when n == m, do: m

  # 2.2 A
  def create(n) do
    create(n, 1)
  end
  def create(n, i) when i < n do
    [i | create(n, i + 1)]
  end
  def create(n, n), do: [n]

  # 2.2 B
  def reverse_create(1), do: [1]
  def reverse_create(n) do
    [n | reverse_create(n - 1)]
  end

  # 2.3 A
  def print(n) do
    print(n, 1)
  end
  def print(n, i) when i < n do
    IO.puts(i)
    print(n, i + 1)
  end
  def print(n, n) do
     IO.puts(n)
  end

  # 2.3 B
  def even_print(n) do
    even_print(n, 2)
  end
  def even_print(n, i) when i > n, do: :ok
  def even_print(n, i) when rem(i,2) == 0 do
    IO.puts(i)
    even_print(n, i + 2)
  end
end
