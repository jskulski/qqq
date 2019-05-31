require 'uuidtools'

def define_cli(&content)
  <<-EOF
  require 'thor'
  require 'redis'
  require 'json'

  module QQQ
    class CLI < Thor
      #{content.call}
    end
  end
  EOF
end

def define_command(command_name, &content)
puts 'JSK'
  <<-EOF
desc "tail", "hi"
#{define_function(command_name) do
    content.call
  end }
  EOF
end

def define_function(func_name, &content)
  <<-EOF
def #{func_name}
#{content.call}
end
  EOF
end

def pubsub_subscribe(channel_name, &content)
  <<-EOF
redis = Redis.new 
redis.subscribe(#{channel_name}) do |on| 
  on.message do |_channel, event|
    #{content.call} 
  end
end
  EOF
end

def pubsub_publish(channel_name, event)
<<-EOF
redis = Redis.new
redis.publish(#{channel_name}, #{event})
EOF
end

def event_json(event)
  # @requires = 'json'
<<-EOF
  #{event}.to_json
EOF
end


def event_from_message(message)
<<-EOF
  {
    uuid: UUIDTools::UUID.random_create().to_s.split('-').first,
    recorded_at: Time.now,
    message: "#{message}"
  }
EOF
end

def print_command(&block)
  <<-EOF
  puts event
  EOF
end

def human_format
  "puts event"
end

def run(code)
  puts
  puts "Generated: "
  puts code

  eval(code)

  QQQ::CLI.start(['mark'])
end
