require "json"
require "thread"
require "httpclient"
require "socket"

class PushDaemon
  def initialize
    @queue = Queue.new
    @client = HTTPClient.new
    @socket = UDPSocket.new
  end

  def start
    worker
    bind
    listen
  end

  def bind
    @socket.bind("0.0.0.0", 6889)
  end

  def listen
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
          @queue << json
      end
    end
  end

  def worker
    10.times do
      Thread.new do
        while data = @queue.pop
          @client.post("https://android.googleapis.com/gcm/send", data,
                       {
                          "Authorization" => "key=AIzaSyCABSTd47XeIH",
                          "Content-Type" => "application/json"
                       })
        end
      end
    end
  end
end
