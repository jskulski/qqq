module QQQ
  class Event
    def initialize(uuid:, message:, recorded_at:)
      @uuid = uuid
      @message = message
      @recorded_at = recorded_at
    end

  end
end