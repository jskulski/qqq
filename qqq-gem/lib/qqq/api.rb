require 'faraday'

module QQQ
  module API
    def self.publish(msg)
      conn = Faraday.new(:url => "http://localhost:3600")
      resp = conn.post '/messages', { :message => { message: msg } }
      puts resp.status
    end
  end
end