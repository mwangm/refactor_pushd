require_relative "ping"
require_relative "send"

module Jobs
  def self.factory data, server
    case data[0].split.first
      when "PING"
        Jobs::Ping.new(server, data)
      when "SEND"
        Jobs::Send.new(server, data)
    end
  end
end