require 'redis'
require 'json'

# Lib
require 'qqq/event'
require 'qqq/api'
require 'qqq/cli'
require 'qqq/keys'
require 'qqq/version'

require 'uuidtools'

module QQQ
  class Error < StandardError; end

  def self.qqq(message)
    publish(message)
  end

  def self.publish(message)
    @redis = Redis.new

    uuid = UUIDTools::UUID.random_create().to_s
    timestamp = Time.now

    message_for_humans = "[#{uuid}] [#{timestamp}] #{message}"
    @redis.publish(Keys::MESSAGES_CHANNEL_KEY, message_for_humans.to_json)

    event = Event.new(uuid: uuid, message: message, recorded_at: timestamp)
    @redis.publish(Keys::EVENT_CHANNEL_KEY, event.to_json)
  end

  def self.subscribe &block
    @redis = Redis.new
    @redis.subscribe Keys::EVENT_CHANNEL_KEY do |on|
      puts "Connected..."

      on.message do |channel, event_json_string|
        event = Event.from(json_string: event_json_string)
        block.call(event)
      end
    end
  end
end

