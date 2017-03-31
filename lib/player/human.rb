class Player
  class Human
    attr_accessor :player

    def status
      :human
    end

    def zombie_like?
      false
    end

    def human_like?
      true
    end

    def touch(another_player)
      another_player.role.handshaked
    end

    def handshaked
      player.update_scores(+1)
      true
    end

    def infected
      player.update_role TemporaryInfected.new
      true
    end

    def antidote_applied
      false
    end

    def next_turn
      false
    end
  end
end
