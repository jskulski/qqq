module QQQ
  module FileAppender
    FILEPATH = '/tmp/qqq'

    def self.append(event)
      f = File.open(FILEPATH, 'a')
      f.write(event.for_humans)
      f.write("\n")
      f.close
    end
  end
end
