def define_cli(&content)
<<-EOF
  require 'thor'
  require 'redis'

  module QQQ
    class CLI < Thor
      #{content.call}
    end
  end
EOF
end

def define_command(command_name, &content)
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

def print_command(&block)
<<-EOF
  puts event
EOF
end

def human_format
  "puts event"
end

EVENTS_CHANNEL = "\"qqq::channel::event\""

code = define_cli do
  define_command(:tail) do
    pubsub_subscribe(EVENTS_CHANNEL) do
      print_command do
        human_format
      end
    end
  end
end

puts
puts "Generated: "
puts
puts code

# f = File.open('qqq-ruby.rb', 'w')
# f.write(code)
# f.close
# system('ruby qqq-ruby.rb')
# end

eval(code)

QQQ::CLI.start(['tail'])
