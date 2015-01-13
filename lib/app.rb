require "server"
require "json"
require "jobs/ping"
require "jobs/send"

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
    case data[0].split.first
      when "PING"
        @queue << Jobs::Ping.new(@server, data)
      when "SEND"
        @queue << Jobs::Send.new(@server, data)
    end
  end
end