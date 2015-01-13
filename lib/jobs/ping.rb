module Jobs
  class Ping
    def initialize(server, data)
      @server = server
      @data = data
    end

    def run
      @server.send("PONG", @data[1][3], @data[1][1])
    end
  end
end