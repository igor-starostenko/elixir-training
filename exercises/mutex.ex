defmodule Mutex do
  def start() do
    pid = spawn(Mutex, :free, [])
    Process.register(pid, :mutex)
  end

  def stop() do
    send(:mutex, :stop)
    :ok
  end

  def wait() do
    send(:mutex, {:wait, self()})
    receive do
      :ok -> :ok
    end
  end

  def signal() do
    send(:mutex, {:signal, self()})
    :ok
  end

  def free() do
    receive do
      :stop -> :ok
      {:wait, pid} -> 
        busy(pid)
    end
  end

  def busy(pid) do
    send(pid, :ok) 
    receive do
      :stop -> :ok
      {:signal, ^pid} ->
        free()
    after 10000 ->
      IO.puts("Timeout")
      free()
    end
  end
end
