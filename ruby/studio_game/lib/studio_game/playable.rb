module StudioGame
  module Playable
    def blam
      @health -= 10
      puts "#{@name} got blammed!"
    end

    def w00t
      @health += 15
      puts "#{@name} got w00ted!"
    end

    def strong?
      if @health >= 150
        true
      else
        false
      end
    end
  end
end