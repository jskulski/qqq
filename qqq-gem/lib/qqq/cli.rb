require 'thor'
require 'qqq/file'

module QQQ
  class CLI < Thor
    default_task "tail"

    desc "tail", "Tails the qqq log"
    def tail
      QQQ.dev.subscribe do |event|
        puts event.for_humans
      end
    end

    desc "mark [repeat_interval]", "Marks the log (optionally every X seconds)"
    def mark(repeat_interval)
      repeat_interval = repeat_interval.to_i rescue 0
      loop do
        QQQ.dev.mark
        if repeat_interval > 0
          sleep repeat_interval
        else
          break
        end
      end
    end

    desc "echo [messages]", "Log a message"
    def echo(*messages)
      QQQ.dev.publish("#{messages.join(" ")}")
    end

    desc :version, "Logs the version number"
    def version
      puts "QQQ version: #{QQQ::VERSION}"
      QQQ.dev.publish(QQQ::VERSION)
    end

    #
    # Files
    # (TODO: split)
    desc "file", "Server"
    def file
      QQQ.dev.subscribe do |event|
        QQQ::FileAppender.append(event)
      end
    end

    desc "filetail", "Tails the qqq log"
    def filetail
      system("tail -f #{QQQ::FileAppender::FILEPATH}")
    end
  end
end

