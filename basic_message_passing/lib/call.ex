defmodule BasicMessagePassing.Call do

  def concat(a, b) do
    IO.puts(a <> " " <> b)
  end

end

BasicMessagePassing.Call.concat("Elixir", "Madrid")

spawn(BasicMessagePassing.Call, :concat, ["Elixir", "Madrid"])