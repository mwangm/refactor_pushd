module Jobs
  class Send
    def initialize(server, data)
      @server = server
      @data = data
    end

    def run
      @data[0][5..-1].match(/([a-zA-Z0-9_\-]*) "([^"]*)/)
      JSON.generate({
                        "registration_ids" => [$1],
                        "data" => {"alert" => $2}
                    })
    end
  end
end