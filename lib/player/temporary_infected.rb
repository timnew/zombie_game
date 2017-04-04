class Player
  class TemporaryInfected < Zombie
    attr_accessor :infectness

    def initialize
      @infectness = 0
    end

    def status
      :temporary_infected
    end

    def touch(another_player)
      another_player.role.infected
    end

    def handshaked
      false
    end

    def infected
      false
    end

    def antidote_applied
      player.update_role Human.new
      true
    end

    def next_turn
      @infectness += 1

      return false unless @infectness < player.game.antidote_limit

      player.update_role PermanentInfected.new
      true
    end
  end
end
