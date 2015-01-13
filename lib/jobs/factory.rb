require_relative "ping"
require_relative "send"

module Jobs
  def self.factory data, server
      job_type = data[0].split.first.capitalize
      const_get(job_type).new(server, data)
  end
end