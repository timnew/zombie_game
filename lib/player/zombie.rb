class Player
  class Zombie
    attr_accessor :player

    def name
      'Zombie'
    end

    def zombie_like?
      true
    end

    def human_like?
      false
    end

    def touch(another_player)
      another_player.role.infected
    end

    def handshaked
    end

    def infected
    end

    def antidote_applied
    end

    def next_round
    end
  end
end
