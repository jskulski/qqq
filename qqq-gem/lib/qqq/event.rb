module QQQ
  class Event

    attr_reader :uuid, :message, :recorded_at

    def self.from(json_string:)
      payload = JSON.parse json_string
      puts payload
      Event.new(uuid: payload["uuid"], message: payload["message"], recorded_at: payload["recorded_at"])
    end

    def initialize(uuid:, message:, recorded_at:)
      @uuid = uuid
      @message = message
      @recorded_at = recorded_at
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
