defmodule FibSerial do

	def calculate(ns) do
		ns
		|> Enum.map(&(calc(&1)))
		|> inspect
		|> IO.puts
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


FibSerial.calculate(Enum.to_list(1..10000))