require 'thor'
require 'json'

module QQQ
  class CLI < Thor
    default_task :tail

    desc :tail, "Tails the qqq log"
    def tail
      puts "hi"
      QQQ.subscribe do |msg|
        puts msg
      end
    end

    desc :payload, "For now- separate tail"
    def payload
      QQQ.subscribe_payload do |payload|
        puts payload.to_s
      end
    end

    desc :mark, "Marks the log"
    def mark
      QQQ.publish("MARK: --MARK--")
    end

    desc "echo [message]", "Simple echo"
    def echo(message)
      QQQ.publish("ECHO: #{message}")
    end

    desc :send, "Sends message to a remote server"
    def send
      QQQ.subscribe do |msg|
        puts "Remotely publishing: #{msg}"
        API.publish(msg)
      end
    end

    # desc :server, "Starts server to receive message"
    # def server
    #   Sinatra....how?
    # end
  end
end

