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

    payload = {message: message, uuid: UUIDTools::UUID.random_create()}
    payload_json = payload.to_json

    @redis.publish(Keys::MESSAGES_CHANNEL_KEY, message)
    @redis.publish(Keys::PAYLOAD_CHANNEL_KEY, payload_json)
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

