defmodule Sample.Calendar do

    def is_leap_year(year) when rem(year, 4) == 0, do: true
    def is_leap_year(year), do: false
  
end
