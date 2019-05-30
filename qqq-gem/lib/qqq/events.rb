require 'uuidtools'

module QQQ
  class Event

    attr_reader :uuid, :message, :recorded_at

    def self.from_message(message)
      timestamp = Time.now
      uuid = UUIDTools::UUID.random_create().to_s.split('-').first
      Event.new(uuid: uuid, message: message, recorded_at: timestamp)
    end

    def self.from_json_string(json_string)
      payload = JSON.parse json_string
      Event.new(uuid: payload["uuid"], message: payload["message"], recorded_at: payload["recorded_at"])
    end

    def initialize(uuid:, message:, recorded_at:)
      @uuid = uuid
      @recorded_at = recorded_at
      @message = message
    end

    def for_humans
      "[#{@uuid}] [#{@recorded_at}] #{@message}"
    end

    def as_json(options={})
      { uuid: @uuid,
        message: @message,
        recorded_at: @recorded_at,
      }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

  end

end
