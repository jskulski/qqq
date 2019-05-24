require 'thor'
require 'json'

module QQQ
  class CLI < Thor
    default_task :tail

    desc :tail, "Tails the qqq log"
    def tail
      QQQ.subscribe do |event|
        puts event.message
      end
    end

    desc :payload, "For now- separate tail"
    def payload
      QQQ.subscribe do |event|
        puts event.to_s
      end
    end

    desc :mark, "Marks the log"
    def mark
      QQQ.publish("MARK: --MARK--")
    end

    desc "echo [messages]", "Simple echo"
    def echo(*messages)
      QQQ.publish("ECHO: #{messages.join(" ")}")
    end

    desc :send, "Sends message to a remote server"
    def send
      QQQ.subscribe do |event|
        puts "Remotely publishing: #{event.message}"
        API.publish(event)
      end
    end

    # desc :server, "Starts server to receive message"
    # def server
    #   Sinatra....how?
    # end
  end
end

