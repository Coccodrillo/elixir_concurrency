defmodule BasicMessagePassing.Listen do
  def listen do
    receive do
      {:ok, input} -> IO.puts "#{input} Madrid"
    end
  end
end

pid = spawn(BasicMessagePassing.Listen, :listen, [])

send pid, {:ok, "Elixir"}

send pid, :ok