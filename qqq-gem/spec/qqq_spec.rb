# require 'fakeredis'

RSpec.describe QQQ do
  it "has a version number" do
    expect(QQQ::VERSION).not_to be nil
  end

  it "publishes a message to redis" do
    QQQ::qqq("MESSAGE STUB")
  end
end
