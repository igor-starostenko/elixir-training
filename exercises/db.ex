defmodule Db do
  # 2.4
  def new, do: []
 
  def write([], name, city) do
    [{name, city}]
  end
  def write([{name, _} | db], name, city) do
    [{name, city} | db ]
  end
  def write([current | db], name, city) do
    [current | write(db, name, city)]
  end

  def read(db, name) do
    case db[name] do
      nil -> {:error, :instance}
      city -> {:ok, city}
    end
  end

  def match([], _city), do: []
  def match([{name, city} | db], city) do
    [name | match(db, city)]
  end
  def match([_ | db], city) do
    match(db, city)
  end

  def delete([], _name), do: []
  def delete([{name, _} | db], name) do
    delete(db, name)
  end
  def delete([other | db], name) do
    [other | delete(db, name)]
  end

  def destroy, do: :ok

end
