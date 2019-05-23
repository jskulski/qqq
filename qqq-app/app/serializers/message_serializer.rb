class MessageSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :message, :recorded_at
end