class Server
  def initialize
    @socket = UDPSocket.new
  end

  def listen(port, &process)
    @socket.bind("0.0.0.0", port)
    loop { process.call receive }
  end

  def receive
    @socket.recvfrom(4096)
  end

  def send(message, address, port)
    @socket.send(message, 0, address, port)
  end
end