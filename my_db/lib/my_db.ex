defmodule MyDb do
  @moduledoc """
  API module forwarding the calls to the DbServer module.

  # Examples:
  iex> MyDb.start
  iex> MyDb.write(:igor, :santamonica)
  :ok
  iex> MyDb.read(:igor) 
  {:ok, :santamonica} 
  iex> MyDb.write(:igor, :calabasas)  
  :ok
  iex> MyDb.read(:igor) 
  {:ok, :calabasas}
  iex> MyDb.read(:no_key)
  {:error, :instance}
  iex> MyDb.write(:hanna, :culvercity)
  iex> MyDb.write(:julia, :culvercity)
  iex> MyDb.match(:culvercity)
  [:hanna, :julia]
  iex> MyDb.delete(:igor)
  :ok
  iex> MyDb.read(:igor)
  {:error, :instance}
  iex> MyDb.destroy
  :ok
  iex> MyDb.write(:igor, :santamonica)
  :error
  iex> MyDb.read(:igor)
  :errorbrew
  iex> MyDb.match(:igor)
  :error
  iex> MyDb.delete(:igor)
  :error
  iex> MyDb.stop
  :ok
  """
  alias MyDb.DbServer, as: DbServer
  alias MyDb.DbServer.DbList, as: DbList

  def start do
    pid = spawn(DbServer, :loop, [DbList.new])
    Process.register(pid, :db)
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

  defp sync_call(message) do
    send(:db, {:request, self(), message})
    receive do
      {:reply, reply} -> reply
    end
  end
end
