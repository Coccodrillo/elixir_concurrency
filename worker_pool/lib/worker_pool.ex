defmodule WorkerPool do
  use Application

  @pool_name :warm_pool

  def start(_type, _args) do
    poolboy_config = [
      {:name, {:local, @pool_name}},
      {:broadcast_to_workers, true},
      {:worker_module, WorkerPool.WorkerGenServer},
      {:size, 2},
      {:max_overflow, 2},
      {:overflow_ttl, 0}
    ]

    children = [
      :poolboy.child_spec(@pool_name, poolboy_config, [])
    ]

    options = [
      name: WorkerPool.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end

  def serial(num) do
    worker(num)
  end

  defp worker(num) do
    :poolboy.transaction(
      @pool_name,
      fn(pid) -> WorkerPool.WorkerGenServer.do_work(pid, num) end
    )
  end

  def parallel(range) do
    Enum.each(
      range,
      fn(num) -> spawn( fn() -> worker(num) end ) end
    )
  end

end