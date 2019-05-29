require 'thor'

module QQQ
  class CLI < Thor
    default_task "tail"

    desc "tail", "Tails the qqq log"
    def tail
      qqq.subscribe do |event|
        puts event.for_humans
      end
    end

    desc "mark [repeat_interval]", "Marks the log (optionally every X seconds)"
    def mark(repeat_interval)
      repeat_interval = repeat_interval.to_i rescue 0
      loop do
        qqq.mark

        if repeat_interval > 0
          sleep repeat_interval
        else
          break
        end
      end
    end

    desc "echo [messages]", "Log a message"
    def echo(*messages)
      QQQ.publish("#{messages.join(" ")}")
    end

    desc :version, "Logs the version number"
    def version
      puts "QQQ version: #{QQQ::VERSION}"
      QQQ.publish(QQQ::VERSION)
    end
  end
end

