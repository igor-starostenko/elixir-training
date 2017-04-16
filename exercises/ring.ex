defmodule Ring do
  @moduledoc """
  3.2
  Implements a server that creates n processes connected in a ring.
  """

  def start(ringsize, nummes, message) do
    spawn(Ring, :master, [ringsize, nummes, message])
  end

  def master(ringsize, nummes, message) do
    pid = make_ring(ringsize, self())
    master_loop(nummes, message, pid)
  end

  def make_ring(1, pid), do: pid
  def make_ring(ringsize, pid) do
    newpid = spawn(Ring, :loop, [ringsize, pid])
    make_ring(ringsize - 1, newpid)
  end

  def master_loop(0, _, pid) do
    IO.puts("Terminating Master process")
    send(pid, :stop)
  end 
  def master_loop(nummes, message, pid) do
    send(pid, message)
    receive do
      message ->
        IO.puts("Master received a #{message}")
        master_loop(nummes - 1, message, pid)
    end
  end

  def loop(ringsize, pid) do
    receive do
      :stop ->
        IO.puts("Terminating #{inspect(ringsize)} process")
        send(pid, :stop)
      message ->
        IO.puts("Process #{inspect(ringsize)} received #{inspect(message)}")
        send(pid, message)
        loop(ringsize, pid)
    end
  end
end
