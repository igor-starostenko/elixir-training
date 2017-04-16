# Recursion example
defmodule Calculator do

  def sum([head | tail], acc) do
    sum(tail, head + acc)
  end
  def sum([], acc), do: acc

  def mul(list, val, new_list \\ [])
  def mul([], _val, new_list), do: revert_list(new_list)
  def mul([h | t], val, new_list) do
    mul(t, val, [h * val | new_list])
  end

  def revert_list(list, new_list \\ [])
  def revert_list([head | tail], new_list) do
    revert_list(tail, [head | new_list])
  end
  def revert_list([], new_list), do: new_list
end
