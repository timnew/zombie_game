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
      player.update_score(+1) if another_player.role.infected
    end

    def handshaked
      false
    end

    def infected
      false
    end

    def antidote_applied
      false
    end

    def next_round
    end
  end
end
