# Gems
require 'redis'
require 'json'
require 'uuidtools'

# Lib
require 'qqq/events'
require 'qqq/api'
require 'qqq/cli'
require 'qqq/keys'
require 'qqq/version'



module Kernel
  private
  def q(message:nil)
    @qqq_developer ||= QQQ::Developer.new
    message ? @qqq_developer.publish(message) : @qqq_developer.mark
    @qqq_developer
  end

  def qqq(message: nil)
    @qqq_developer ||= QQQ::Developer.new
    message ? @qqq_developer.publish(message) : @qqq_developer.mark
    @qqq_developer
  end
end

module QQQ
  class Error < StandardError; end

  #
  # Developer log channels
  #
  class Developer

    def initialize
      @mark_counter = 0
    end

    def mark
      @mark_counter += 1
      publish("MARK: --MARK-- (#{@mark_counter})")
    end

    def publish(message)
      event = Event.from_message(message)
      redis.publish(Keys::EVENT_CHANNEL_KEY, event.to_json)
    end

    def subscribe &block
      redis.subscribe Keys::EVENT_CHANNEL_KEY do |on|
        on.message do |channel, event_json_string|
          event = Event.from_json_string(event_json_string)
          block.call(event)
        end
      end
    end

    private

    def redis
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
end

