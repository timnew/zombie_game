class Player
  class TemporaryInfected < Zombie
    attr_accessor :infectness

    def initialize
      @infectness = 0
    end

    def name
      'Temporary Infected'
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

    def apply_antidote
      player.update_role Human.new
      true
    end

    def next_round
      @infectness += 1
      player.update_role PermanentInfected.new if @infectness > 3
      player.reset_score
    end
  end
end
