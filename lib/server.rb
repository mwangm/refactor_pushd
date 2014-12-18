require "socket"
require "json"

class Server
  def initialize
    @socket = UDPSocket.new
  end

  def start(queue)
    bind
    listen queue
  end

  def bind
    @socket.bind("0.0.0.0", 6889)
  end

  def listen(queue)
    while data = @socket.recvfrom(4096)
      case data[0].split.first
        when "PING"
          @socket.send("PONG", 0, data[1][3], data[1][1])
        when "SEND"
          data[0][5..-1].match(/([a-zA-Z0-9_\-]*) "([^"]*)/)
          json = JSON.generate({
                                   "registration_ids" => [$1],
                                   "data" => {"alert" => $2}
                               })
          queue << json
      end
    end
  end
end