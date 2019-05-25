require 'redis'
require 'json'

# Lib
require 'qqq/events'
require 'qqq/api'
require 'qqq/cli'
require 'qqq/keys'
require 'qqq/version'

require 'uuidtools'

module QQQ
  class Error < StandardError; end

  #
  # Developer log channels
  #

  # message = "hello world"
  def self.qqq(message)
    publish(message)
  end

  def self.publish(message)
    event = Event.from_message(message)
    redis.publish(Keys::EVENT_CHANNEL_KEY, event.to_json)
  end

  def self.subscribe &block
    redis.subscribe Keys::EVENT_CHANNEL_KEY do |on|
      on.message do |channel, event_json_string|
        event = Event.from_json_string(event_json_string)
        block.call(event)
      end
    end
  end

  def self.redis
    if defined?(FakeRedis) && FakeRedis.enabled?
      FakeRedis.disable
      @redis ||= Redis.new
      FakeRedis.enable
    else
      @redis ||= Redis.new
    end

    @redis
  end

end

