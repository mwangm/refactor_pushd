require_relative 'app'
require_relative 'worker'

class PushDaemon
  def initialize
    @queue = Queue.new
    @server = App.new(@queue)
    @worker = Worker.new
  end

  def start
    @worker.start(@queue)
    @server.start
  end
end
