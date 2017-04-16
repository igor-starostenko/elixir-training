defmodule MyDb do
  @moduledoc """
  4.1
  Implements a server with Db functions.
  """

  def start do
    pid = spawn(MyDb, :loop, [Db.new])
    Process.register(pid, :db)
  end

  defp sync_call(message) do
    send(:db, {:request, self(), message})
    receive do
      {:reply, reply} -> reply
    end
  end

  defp reply(pid, reply) do
    send(pid, {:reply, reply})
  end

  def new do
    send(:db, :new)
    :ok
  end

  def write(name, city) do
    sync_call({:write, name, city})
  end

  def read(name) do
    sync_call({:read, name})
  end

  def delete(name) do
    sync_call({:delete, name})
  end

  def match(city) do
    sync_call({:match, city})
  end

  def destroy do
    send(:db, :destroy)
    :ok
  end

  def stop do
    send(:db, :stop)
    :ok
  end

  def loop(db) do
    receive do
      :new -> loop(Db.new)
      {:request, pid, {:write, name, city} } ->
        newdb = Db.write(db, name, city)
        reply(pid, :ok)
        loop(newdb)
      {:request, pid, {:read, name} } ->
        reply(pid, Db.read(db, name))
        loop(db)
      {:request, pid, {:match, city} } ->
        reply(pid, Db.match(db, city))
        loop(db)
      {:request, pid, {:delete, name} } ->
        newdb = Db.delete(db, name)
        reply(pid, :ok)
        loop(newdb)
      :destroy ->
        newdb = Db.destroy
        loop(newdb)
      :stop -> :ok
    end
  end
end
