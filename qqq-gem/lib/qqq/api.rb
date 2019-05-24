require 'faraday'

module QQQ
  module API
    def self.publish(event)
      conn = Faraday.new(:url => "http://localhost:3600")
      resp = conn.post '/events', { :event => event.as_json }
      puts resp.status, resp.body
    end
  end
end
