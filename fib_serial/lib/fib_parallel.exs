defmodule FibParallel do
  def calculate(ns) do
    ns
    |> Enum.with_index
    |> Enum.map(fn(ni) ->
      spawn FibParallel, :send_calc, [self, ni]
    end)
    recieve(length(ns), [])
  end

  def send_calc(pid, {n, i}) do
    send pid, {calc(n), i}
  end

  defp recieve(lns, result) do
    receive do
      fib ->
        result = [fib | result]

        if lns == 1 do
          result
          |> Enum.sort(fn({_, a}, {_, b}) -> a < b end)
          |> Enum.map(fn({f, _}) -> f end)
          |> inspect
          |> IO.puts
        else
          recieve(lns - 1, result)
        end
    end
  end

  def calc(n) do
    calc(n, 1, 0)
  end

  defp calc(0, _, _) do
    0
  end

  defp calc(1, a, b) do
    a + b
  end

  defp calc(n, a, b) do
    calc(n - 1, b, a + b)
  end

end

FibParallel.calculate(Enum.to_list(1..10000))