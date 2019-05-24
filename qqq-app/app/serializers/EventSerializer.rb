class EventSerializer < ActiveModel::Serializer
  attributes :uuid, :message, :recorded_at
end