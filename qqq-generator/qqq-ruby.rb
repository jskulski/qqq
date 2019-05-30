  require 'thor'

  module QQQ
    class CLI < Thor
      desc "tail", "hi"
def tail
redis = Redis.new 
redis.subscribe do |event| 
    puts event.for_humans
 
end

end


    end
  end
