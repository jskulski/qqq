require 'redis'
require 'json'

# Lib
require 'qqq/api'
require 'qqq/cli'
require 'qqq/keys'
require 'qqq/version'

require 'uuidtools'

module QQQ
  class Error < StandardError; end

  # message = 'hi'
  def self.qqq(message)
    publish(message)
  end

  def self.publish(message)
    @redis = Redis.new

    uuid = UUIDTools::UUID.random_create()

    timestamp = Time.now

    message_for_humans = "[#{uuid}] [#{timestamp}] #{message}"
    @redis.publish(Keys::MESSAGES_CHANNEL_KEY, message_for_humans.to_json)

    payload = {message: message, uuid: uuid, recorded_at: timestamp}
    @redis.publish(Keys::PAYLOAD_CHANNEL_KEY, payload.to_json)

    # event = Event.new(message: message, uuid: uuid, recorded_at: timestamp)
    # @redis.publish(Keys::EVENTS_CHANNEL_KEY, event.to_json)
  end

  def self.subscribe &block
    @redis = Redis.new
    @redis.subscribe Keys::MESSAGES_CHANNEL_KEY do |on|
      puts "Connected..."

      on.message do |channel, msg|
        block.call(msg)
      end
    end
  end

  def self.subscribe_payload &block
    @redis = Redis.new
    @redis.subscribe Keys::PAYLOAD_CHANNEL_KEY do |on|
      puts "Connected..."

      on.message do |channel, payload_json_string|
        payload = JSON.parse payload_json_string
        block.call(payload)
      end
    end
  end
end

