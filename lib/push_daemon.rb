require_relative 'server'
require_relative 'worker'

class PushDaemon
  def initialize
    @queue = Queue.new
    @server = Server.new
    @worker = Worker.new
  end

  def start
    @worker.start(@queue)
    @server.start(@queue)
  end
end
