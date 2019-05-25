require 'redis'
require 'json'

# Lib
require 'qqq/models'
require 'qqq/api'
require 'qqq/cli'
require 'qqq/keys'
require 'qqq/version'

require 'uuidtools'

module QQQ
  class Error < StandardError; end

  #
  # Dev log
  #

  # message = "hello world"
  def self.qqq(message)
    publish(message)
  end

  def self.publish(message)
    timestamp = Time.now
    uuid = UUIDTools::UUID.random_create().to_s
    event = Event.new(uuid: uuid, message: message, recorded_at: timestamp)

    redis.publish(Keys::EVENT_CHANNEL_KEY, event.to_json)
  end

  def self.subscribe &block
    system_event(:subscribed_to_events)

    redis.subscribe Keys::EVENT_CHANNEL_KEY do |on|
      on.message do |channel, event_json_string|
        event = Event.from(json_string: event_json_string)
        block.call(event)
      end
    end
  end

  #
  # System communication
  #


  def self.system_event(topic)
    SystemEvent.new
    redis.publish(Keys::SYSTEM_CHANNEL_KEY, event_hash.to_json)
  end

  def self.system_when(topic)
    redis.subscribe Keys::SYSTEM_CHANNEL_KEY do |on|
      on.message do |channel, event_json_string|
        event = Event.from(json_string: event_json_string)
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

