defmodule S do

  ## iex --name foo@127.0.0.1
  ## s = self()
  ## Node.spawn(:"bar@127.0.0.1", fn() -> send(s,node()) end )
  ## flush()

  def s do
    Process.register(self(), :server)
    l() 
  end

  def l do
    receive do
      {m, pid} -> send(pid, m ++ ' world')
    end
    l()
  end

  ## Example:
  # iex(foo@node)4> Node.spawn(:bar@node, S, :s, [])
  # PID#<5827.47.0>
  # iex(foo@node)5> send {:server, :bar@node}, {'hi', self()}
  # {'hi', PID#<0.37.0>}
  # iex(foo@node)6> flush().
  # 'hi world'

end
