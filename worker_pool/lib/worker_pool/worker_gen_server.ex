defmodule WorkerPool.WorkerGenServer do
  use GenServer

  def start_link([]) do
    :gen_server.start_link(__MODULE__, [], [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(data, _, state) do
    result = WorkerPool.Worker.do_work(data)
    IO.puts result
    {:reply, [result], state}
  end

  def do_work(pid, num) do
    :gen_server.call(pid, num)
  end
end
