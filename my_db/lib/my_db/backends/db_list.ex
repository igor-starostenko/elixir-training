defmodule MyDb.DbServer.DbList do
  @moduledoc """
  6.2 - Database operations
  """

  def new, do: Map.new

  def write(db, name, city) do
    Map.put(db, name, city)
  end

  def read(db, name) do
    case Map.fetch(db, name) do
      :error -> {:error, :instance}
      city -> city
    end
  end

  def match(db, city) do
    # Enum.filter_map(db, fn({_, c}) -> c === city end,
    #                     fn({name, _}) -> name end)
    for {n, c} <- db, c === city, do: n
  end

  def delete(db, name) do
    Map.delete(db, name)
  end

  def destroy, do: :ok
end
