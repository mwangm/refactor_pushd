require "server"
require "json"

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
        @server.send("PONG", data[1][3], data[1][1])
      when "SEND"
        data[0][5..-1].match(/([a-zA-Z0-9_\-]*) "([^"]*)/)
        json = JSON.generate({
                                 "registration_ids" => [$1],
                                 "data" => {"alert" => $2}
                             })
        @queue << json
    end
  end
end