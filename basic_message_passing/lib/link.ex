defmodule BasicMessagePassing.Linking do
  def exit, do: exit(:crash)
  def start do
    Process.flag(:trap_exit, true)
    spawn_link(BasicMessagePassing.Linking, :exit, [])

    receive do
      {:EXIT, from_pid, reason} -> IO.puts "#{Kernel.inspect(self)} is aware #{Kernel.inspect(from_pid)} exited because of #{reason}"
    end
  end
end

BasicMessagePassing.Linking.start