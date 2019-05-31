module Gen
  EVENTS_CHANNEL = "\"qqq::channel::event\""

  def self.ruby
    puts "generating ruby"
    require './gen/ruby'
    code = gen
    run(code)
  end

  def self.node
    puts "generating node"
    require './gen/node'
    code = gen
    run(code)
  end

  def self.gen
    define_cli do
      define_command(:tail) do
        pubsub_subscribe(EVENTS_CHANNEL) do
          print_command do
            human_format
          end
        end
      end

      define_command(:mark) do
        payload = event_json(event_from_message("--MARK--"))
        pubsub_publish(EVENTS_CHANNEL, payload)
      end
    end
  end
end

if ARGV[0] == 'ruby'
  Gen.ruby
else
  Gen.node
end

