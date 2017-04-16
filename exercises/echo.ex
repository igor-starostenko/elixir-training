defmodule Echo do
  @moduledoc """
  3.1
  Implements a server which will print messages sent to it.
  """
  def start do
    pid = spawn(Echo, :loop, [])
    Process.register(pid, :echo)
    pid
  end

  def stop do
    send(:echo, :stop)
    :ok
  end

  def print(message) do
    send(:echo, {:print, message})
    :ok
  end

  def loop do
    receive do
      {:print, message} ->
        IO.puts(inspect(message))
        loop()
      :stop ->
        :ok
    end
  end
  
end
