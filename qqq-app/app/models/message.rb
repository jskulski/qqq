class Message < ApplicationRecord
  validates_presence_of :uuid, :message, :recorded_at
end
