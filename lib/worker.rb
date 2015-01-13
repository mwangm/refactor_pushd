require "httpclient"
require "thread"

class Worker
  def initialize
    @client = HTTPClient.new
  end

  def consume queue
    10.times do
      Thread.new { work(queue) }
    end
  end

  def work(queue)
    while job = queue.pop
      job.run
    end
  end
end
