require 'thor'
require 'json'

module QQQ
  class CLI < Thor
    default_task :tail

    desc :tail, "Tails the qqq log"
    def tail
      QQQ.subscribe do |event|
        puts event.for_humans
      end
    end

    desc :mark, "Marks the log"
    def mark
      QQQ.publish("MARK: --MARK--")
    end

    desc "echo [messages]", "Log a message"
    def echo(*messages)
      QQQ.publish("#{messages.join(" ")}")
    end

    desc "hello", "Waits for a subscriber then says hello"
    def hello
      QQQ.system_when(:subscribed_to_events) do |subscriber_id|
        QQQ.publish
      end
    end

    desc :version, "Logs the version number"
    def version
      puts "QQQ version: #{QQQ::VERSION}"
      QQQ.publish(QQQ::VERSION)
    end
  end
end

