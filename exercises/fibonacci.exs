defmodule MyRecur do
  def fib(n) when is_integer(n) and n > 1 do
    Enum.map(Enum.to_list(1..n), &fibn(&1))
  end

  defp fibn(n, current \\ 0, next \\ 1)
  defp fibn(0, current, _next) do
    #   IO.puts(current)
       current
    end
  defp fibn(n, current, next) do
      IO.puts(current)
      IO.puts(next)
       fibn(n - 1, next, current + next)
    end
end

# MyRecur.fib(10) # [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
