defmodule HOF do
  @moduledoc """
  6.3 High Order Functions
  """

  # def partA(n) do: Enum.each(1..n, &IO.puts/1)
  def partA(n, acc \\ 1)
  def partA(n, acc) when n < acc, do: :ok 
  def partA(n, acc) do
    IO.puts(acc)
    partA(n, 1 + acc)
  end

  def partB(list, n) do
    # Enum.filter(list, &(&1 <= n))
    fun = fn(x) -> n >= x end
    Enum.filter(list, fun)
  end

  def partC(n) do
    Enum.filter(1..n, fn(x) -> rem(x, 2) == 0 end)
    |>Enum.each(fn(x) -> IO.puts(x) end)
  end

  def partD(list_of_lists) do
    # Enum.flat_map(list_of_lists, fn(x) -> x end)
    concatenate = fn(x, acc) -> acc ++ x end
    Enum.reduce(list_of_lists, [], concatenate)
  end

  def partE(list_of_integers) do
    sum = &(&1 + &2)
    Enum.reduce(list_of_integers, 0, sum)
  end

end
