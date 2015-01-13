require "server"
require "json"
require_relative "jobs/factory"

class App
  def initialize queue
    @server = Server.new
    @queue = queue
  end

  def start
    @server.listen(6889) do |data|
      process_request data
    end
  end

  def process_request data
    job = ::Jobs.factory(data, @server)
    @queue << job unless job.nil?
  end
end