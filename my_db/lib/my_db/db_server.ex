defmodule MyDb.DbServer do
  @moduledoc """
  4.1 - Implements a server with Db functions.
  """

  alias MyDb.DbServer.DbList, as: DbList

  def loop(db) when is_atom(db) do
    receive do
      {:request, pid, _} -> 
        reply(pid, :error)
        loop(db)
      :new -> loop(DbList.new)
      :stop -> :ok
    end
  end
  def loop(db) do
    receive do
      {:request, pid, {:write, name, city}} ->
        newdb = DbList.write(db, name, city)
        reply(pid, :ok)
        loop(newdb)
      {:request, pid, {:read, name}} ->
        reply(pid, DbList.read(db, name))
        loop(db)
      {:request, pid, {:match, city}} ->
        reply(pid, DbList.match(db, city))
        loop(db)
      {:request, pid, {:delete, name}} ->
        newdb = DbList.delete(db, name)
        reply(pid, :ok)
        loop(newdb)
      :destroy ->
        newdb = DbList.destroy
        loop(newdb)
      :stop -> :ok
    end
  end

  defp reply(pid, reply) do
    send(pid, {:reply, reply})
  end
end
