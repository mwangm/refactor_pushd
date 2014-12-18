require "httpclient"
require "thread"

class Worker
  def initialize
    @client = HTTPClient.new
  end

  def start queue
    10.times do
      Thread.new do
        while data = queue.pop
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
