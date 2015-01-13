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
        Jobs::Ping.new(@server, data).run
      when "SEND"
        json = Jobs::Send.new(@server, data).run
        @queue << json
    end
  end
end