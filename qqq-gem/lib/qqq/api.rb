require 'faraday'

module QQQ
  module API

    # desc :send, "Sends message to a remote server"
    # def send
    #   QQQ.subscribe do |event|
    #     puts "Remotely publishing: #{event.message}"
    #     API.publish(event)
    #   end
    # end

    def self.publish(event)
      conn = Faraday.new(:url => "http://localhost:3600")
      resp = conn.post '/events', { :event => event.as_json }
      puts resp.status, resp.body
    end
  end
end
