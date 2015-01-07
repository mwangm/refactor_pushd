require "server"
require "json"

class App
  def initialize queue
    @app = Server.new
    @queue = queue
  end

  def start
    @app.bind 6889
    loop { process_request }
  end

  def process_request
    data = @app.receive
    case data[0].split.first
      when "PING"
        @app.send("PONG", data[1][3], data[1][1])
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