require_relative 'app'
require_relative 'worker'

class PushDaemon
  def initialize
    @queue = Queue.new
    @app = App.new(@queue)
    @worker = Worker.new
  end

  def start
    @worker.start(@queue)
    @app.start
  end
end
