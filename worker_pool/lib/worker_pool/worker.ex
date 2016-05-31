defmodule WorkerPool.Worker do
  def do_work(num) do
  	# this is a demo, so we wait a bit otherwise it's over too soon
  	:timer.sleep(1500)
    "#{num}*#{num}+#{num} = #{num * num + num}"
  end
end