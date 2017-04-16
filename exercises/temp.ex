defmodule Temp do
  def convert({:f, temp}), do: {:c, (temp - 32)/1.8}
  def convert({:c, temp}), do: {:f, (temp * 1.8 + 32)}
    
  def f2c(fahrenheit) do
   (fahrenheit - 32)/1.8
  end 
    
  def c2f(celsius) do  
    celsius * 1.8 + 32
  end
end
