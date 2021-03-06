class Player
  class Zombie
    attr_accessor :player

    def status
      :zombie
    end

    def zombie_like?
      true
    end

    def human_like?
      false
    end

    def touch(another_player)
      player.update_scores(-1) if another_player.role.infected
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

    def next_turn
      false
    end
  end
end
