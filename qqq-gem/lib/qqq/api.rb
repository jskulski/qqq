require 'faraday'

module QQQ
  module API
    def self.publish(msg)
      conn = Faraday.new(:url => "http://localhost:4567")
      resp = conn.post '/message', { :message => msg }
      puts resp.status
    end
  end
end